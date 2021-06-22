#lang racket

(provide (all-defined-out))

(define last-non-zero
  (lambda (ls)
    (let/cc k
      (letrec
          ((last-non-zero
            (lambda (ls)
              (cond
                [(null? ls) ls]
                [(eqv? (car ls) `0) (k (last-non-zero (cdr ls)))]
                [else (cons (car ls) (last-non-zero (cdr ls)))]
                ))))
        (last-non-zero ls)))))

(define (lex exp acc)
  (match exp
    [`,x #:when (symbol? x) `(blah ,x)]
    [`,x #:when (symbol? x) (let ([i (index-of acc x)])                      
                              (cond
                                ((eqv? i #f) (cons x `unbound))              
                                (else (cons `var (list i)))))]                
    [`(lambda (,arg) ,body)  `(lambda ,(lex body (cons arg acc))) ]                   
    [`(zero? ,nexp) `(zero ,(lex nexp acc))]
    [`(sub1 ,exp) `(sub1 ,(lex exp acc))]
    [`(* ,nexp1 ,nexp2) `(mult ,(lex nexp1 acc) ,(lex nexp2 acc))]
    [`(let ([,id ,exp]) ,body) `(let ,(lex exp acc) 
                                  ,(lex body (cons id acc))
                                  )]
    [`(let/cc ,k ,body) `(letcc ,(lex body (cons k acc)))]
    [`(if ,cond ,true ,false) `(if ,(lex cond acc) ,(lex true acc) ,(lex false acc))]
    [`(throw ,k ,exp) `(throw ,(lex k acc) ,(lex exp acc))]
    [`(,rator ,rand) `(app ,(lex rator acc) ,(lex rand acc))]
    ))

(define empty-env
  (lambda ()
    (lambda (y k)
      (error 'value-of "unbound identifier"))))
 
(define empty-k
  (lambda ()
    (lambda (v)
      v)))

(define value-of-cps
  (lambda(expr env k)
    (match expr
      [`(const ,expr) (k expr)]
      [`(mult ,x1 ,x2) (value-of-cps x1 env (lambda(v1)
                                              (value-of-cps x2 env (lambda(v2) (k (* v1 v2))))))]
      [`(sub1 ,x) (value-of-cps x env (lambda(v) (k (sub1 v))))]
      [`(zero ,x) (value-of-cps x env (lambda(v) (k (zero? v))))]
      [`(if ,test ,conseq ,alt) (value-of-cps test env (lambda(v)
                                                         (if v
                                                             (value-of-cps conseq env (lambda(x) (k x)))
                                                             (value-of-cps alt env (lambda(y) (k y))))))]
      [`(letcc ,body) (value-of-cps body
                                    (lambda(var k^)   
                                      (if (zero? var)
                                          (k^ k)
                                          (env (- var 1) k^)))
                                    (lambda(v) (k v)))]
      [`(throw ,k-exp ,v-exp) (value-of-cps k-exp env (lambda(k^)
                                                        (value-of-cps v-exp env (lambda(v) (k^ v)))))]
      [`(let ,e ,body)  (value-of-cps e
                                      env
                                      (lambda(v)
                                        (value-of-cps body
                                                      (lambda(var k^)
                                                        (if (zero? var)
                                                            (k^ v)
                                                            (env var k^))) k)))]
      [`(var ,expr) (env expr k)]
      [`(lambda ,body) (k (lambda (val k^)
                            (value-of-cps body
                                          (lambda (var k^^)
                                            (if (zero? var)
                                                (k^^ val)
                                                (env (sub1 var) k^^))) k^)))]
      [`(app ,rator ,rand) (value-of-cps rator env (lambda(v1)
                                                     (value-of-cps rand env (lambda(v2) (v1 v2 k)))))])))