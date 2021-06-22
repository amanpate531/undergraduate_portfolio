#lang racket

(provide (all-defined-out))

(define value-of
  (lambda (exp env)
    (match exp
      [`,b #:when (boolean? b) b]
      [`,n #:when (number? n)  n]
      [`(zero? ,n) (zero? (value-of n env))]
      [`(sub1 ,n) (sub1 (value-of n env))]
      [`(* ,n1 ,n2) (* (value-of n1 env) (value-of n2 env))]
      [`(if ,test ,conseq ,alt) (if (value-of test env)
                                  (value-of conseq env)
                                  (value-of alt env))]
      [`(begin2 ,e1 ,e2) (begin (value-of e1 env) (value-of e2 env))]
      [`(random ,n) (random (value-of n env))]
      [`,y #:when (symbol? y) (apply-env env y)]
      [`(lambda (,x) ,body) (make-closure x body env)]
      [`(,rator ,rand) (apply-closure (value-of rator env)
                                      (value-of rand env))])))

(define empty-env
  (lambda ()
    '()
  )
)

(define extend-env
  (lambda (x y e)
    `((,x . ,y) . ,e)
   )
 )

(define apply-env
  (lambda (e x)
    (cond
      [(assq x e) => cdr]
      [else (error 'e "unbound variable" x)]
     )
   )
 )

(define make-closure
  (lambda (x body e)
    `(make-closure ,x ,body ,e)
   )
)

(define apply-closure
  (lambda (make-closure arg)
    (match make-closure
      [`(make-closure ,x ,body ,e)
       (value-of body (extend-env x arg e))]
     )
   )
 )

; Call by Value

(define empty-env-cbv
  (lambda ()
    '()
   )
 )

(define extend-env-cbv
  (lambda (x y e)
    `((,x . ,y) . ,e)
   )
 )

(define apply-env-cbv
  (lambda (e x)
    (cond
      [(assq x e) => (lambda (p) (cdr p))]
      [else (error 'e "unbound variable" x)]
     )
   )
 )

(define apply-cbv-set!  
  (lambda (e x)
    (cond
      [(assq x e) => cdr]
      [else (error 'e "unbound variable" x)]
     )
   )
 )

(define make-closure-cbv
  (lambda (x body e)
    `(closure ,x ,body ,e)
  )
)

(define apply-closure-cbv       
  (lambda (nake-closure arg)
    (match make-closure
      [`(make-closure ,x ,body ,e)
       (val-of-cbv body (extend-env-cbv x arg e))]
     )
   )
 )

(define val-of-cbv
  (lambda (exp e)
    (match exp
      [`,b (boolean? b) b]
      [`,n (number? n) n]
      [`,x (symbol? x) (apply-env-cbv e x)]
      [`(quote ()) '()]
      [`(null? ,ls) (null? (val-of-cbv ls e))]
      [`(zero? ,n) (zero? (val-of-cbv n e))]
      [`(add1 ,n) (add1 (val-of-cbv n e))]
      [`(sub1 ,n) (sub1 (val-of-cbv n e))]
      [`(* ,n1 ,n2) (* (val-of-cbv n1 e) (val-of-cbv n2 e))]
      [`(if ,test ,conseq ,alt) (if (val-of-cbv test e)
                                    (val-of-cbv conseq e)
                                    (val-of-cbv alt e))]
      [`(begin2 ,e1 ,e2) (begin (val-of-cbv e1 e) (val-of-cbv e2 e))]
      [`(let ([,x ,e3])
          ,body)
       (val-of-cbv body (extend-env-cbv x (val-of-cbv e3 e) e))]
      [`(cons^ ,a ,d)
       (cons (lambda () (val-of-cbv a e))
             (lambda () (val-of-cbv d e)))]
      [`(car^ ,ls)
       (car (val-of-cbv ls e))]
      [`(cdr^ ,ls)
       (cdr (val-of-cbv ls e))]
      [`(cons ,a ,d)
       (cons (val-of-cbv a e) (val-of-cbv d e))]
      [`(car ,ls)
       (car (val-of-cbv ls e))]
      [`(cdr ,ls)
       (car (val-of-cbv ls e))]
      [`(set! ,var ,rhs)
       (let ([val (val-of-cbv rhs e)]
             [var (apply-cbv-set! e var)])
         (set-box! var val))]
      [`(random ,n) (random (val-of-cbv n e))]
      [`(lambda (,x) ,body) (make-closure-cbv x body e)]
      [`(,rator ,rand) (apply-closure-cbv
                        (val-of-cbv rator e)
                        (val-of-cbv rand e))]
    )
  )
)

; Call by Reference

(define empty-env-cbr
  (lambda ()
    '()
   )
)

(define extend-env-cbr
  (lambda (x y e)
    (if (list? y)   
        `((,x . ,y) . ,e)       
        `((,x . , y) . ,e)
    )
  )
)

(define apply-env-cbr
  (lambda (e x)
    (cond
      [(assq x e) => (lambda (p) (cdr p))]
      [else (error 'e "unbound variable" x)]
    )
  )
)

(define apply-cbr-box  
  (lambda (e x)
    (cond
      [(assq x e) => cdr]
      [else (error 'e "unbound variable" x)]
    )
  )
)

(define make-closure-cbr
  (lambda (x body e)
    `(closure ,x ,body ,e)
  )
)

(define apply-closure-cbr       
  (lambda (make-closure arg)
    (match make-closure
      [`(closure ,x ,body ,e)
       (val-of-cbr body (extend-env-cbr x arg e))]
    )
  )
)

(define val-of-cbr
  (lambda (exp e)
    (match exp
      [`,b (boolean? b) b]
      [`,n (number? n) n]
      [`,x (symbol? x) (apply-env-cbr e x)]
      [`(zero? ,n) (zero? (val-of-cbr n e))]
      [`(sub1 ,n) (sub1 (val-of-cbr n e))]
      [`(* ,n1 ,n2) (* (val-of-cbr n1 e) (val-of-cbr n2 e))]
      [`(if ,test ,conseq ,alt) (if (val-of-cbr test e)
                                    (val-of-cbr conseq e)
                                    (val-of-cbr alt e))]
      [`(begin2 ,e1 ,e2) (begin (val-of-cbr e1 e) (val-of-cbr e2 e))]
      [`(set! ,var ,rhs)
       (let ([val (val-of-cbr rhs e)]
             [var (apply-cbr-box e var)])
         (set-box! var val))]
      [`(random ,n) (random (val-of-cbr n e))]
      [`(lambda (,x) ,body) (make-closure-cbr x body e)]
      [`(,rator ,rand) (apply-closure-cbr
                        (val-of-cbr rator e)
                        (val-of-cbr rand e))]
    )
  )
)

; Call by Name

(define make-closure-cbname
  (lambda (x body e)
    `(closure ,x ,body ,e)
  )
)

(define apply-closure-cbname
  (lambda (make-closure arg)
    (match make-closure
      [`(make-closure ,x ,body ,e)
       (val-of-cbname body (extend-env x arg e))]
    )
  )
)

(define val-of-cbname
  (lambda (exp e)
    (match exp
      [`,b (boolean? b) b]
      [`,n (number? n) n]
      [`,x (symbol? x)  (apply-env e x)]
      [`(zero? ,n) (zero? (val-of-cbname n e))]
      [`(sub1 ,n) (sub1 (val-of-cbname n e))]
      [`(* ,n1 ,n2) (* (val-of-cbname n1 e) (val-of-cbname n2 e))]
      [`(if ,test ,conseq ,alt) (if (val-of-cbname test e)
                                    (val-of-cbname conseq e)
                                    (val-of-cbname alt e))]
      [`(begin2 ,e1 ,e2) (begin (val-of-cbname e1 e) (val-of-cbname e2 e))]
      [`(random ,n) (random (val-of-cbname n e))]
      [`(lambda (,x) ,body) (make-closure-cbname x body e)]
      [`(,rator ,rand) (apply-closure-cbname
                        (val-of-cbname rator e)
                        (lambda () (val-of-cbname rand e))
                       )]
    )
  )
)

; Call by Need

(define make-closure-cbneed
  (lambda (x body e)
    `(make-closure ,x ,body ,e)))

(define apply-closure-cbneed
  (lambda (nake-closure arg)
    (match make-closure
      [`(make-closure ,x ,body ,e)
       (val-of-cbneed body (extend-env x arg e))]
    )
  )
)

(define val-of-cbneed
  (lambda (exp e)
    (match exp
      [`,b (boolean? b) b]
      [`,n (number? n) n]
      [`,x (symbol? x) (apply-env e x)]
      [`(zero? ,n) (zero? (val-of-cbneed n e))]
      [`(sub1 ,n) (sub1 (val-of-cbneed n e))]
      [`(* ,n1 ,n2) (* (val-of-cbneed n1 e) (val-of-cbneed n2 e))]
      [`(if ,test ,conseq ,alt) (if (val-of-cbneed test e)
                                    (val-of-cbneed conseq e)
                                    (val-of-cbneed alt e))]
      [`(begin2 ,e1 ,e2) (begin (val-of-cbneed e1 e) (val-of-cbneed e2 e))]
      [`(random ,n) (random (val-of-cbneed n e))]
      [`(lambda (,x) ,body) (make-closure-cbneed x body e)]
      [`(,rator ,rand) (apply-closure-cbneed
                        (val-of-cbneed rator e)
                        (lambda () (val-of-cbneed rand e)))]
    )
  )
)










