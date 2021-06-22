#lang racket

(provide (all-defined-out))

(define list-ref
  (lambda (ls n)
    (letrec
        ((nth-cdr
          (lambda (n)
            (if (number? n)
                (nth-cdr (cons ls n))
                (let ((ls (car n))
                      (n (cdr n)))
                  (if (zero? n)
                      ls
                      (nth-cdr (cons (cdr ls) (- n 1))))))
            )))
      (car (nth-cdr n)))))

(define(contains? x set)
  (cond
    [(null? set) #f]
    [(eqv? x (car set)) #t]
    [else (contains? x (cdr set))]
    )
  )

(define (union set1 set2)
  (cond
    [(null? set1) set2]
    [(contains? (car set1) set2) (union (cdr set1) set2)]
    [else (cons (car set1) (union (cdr set1) set2))]
    )
  )

(define (extend x pred)
  (lambda(y)
    (cond
      [(or (eqv? x y) (pred y)) #t]
      [else #f]
      )
    )
  )

(define (walk-symbol x s)
  (let [(var (assv x s))]
    (cond
      [(eqv? var #f) x]
      [(null? (cdr var)) x]
      [else (walk-symbol (cdr var) s)]
      )
    )
  )

(define (lambda->lumbda x)
  (match x
    [`(lambda (,y) ,body) `(lumbda (,y) ,(lambda->lumbda body))]
    [`(,rator ,rand) `(,(lambda->lumbda rator) ,(lambda->lumbda rand))]
    [else x]
    )
  )

(define (var-occurs? x y)
  (match y
    [`(lambda (,var) ,body)
     (cond [(eqv? var x) #f]
           [else (var-occurs? x body)])]
    [`(,rator ,rand) (or (var-occurs? x rator) (var-occurs? x rand))]
    [`,z (eqv? x z)]
    )
  )

(define (vars x)
  (match x
    [`(lambda (,y) ,body) (vars body)]
    [`(,rator ,rand) (append (vars rator) (vars rand))]
    [else (cons x `())]  
    )
  )

(define (unique-vars x)
  (match x
    [`(lambda (,y) ,body) (unique-vars body)]
    [`(,rator ,rand) (union (unique-vars rator) (unique-vars rand))]
    [else (cons x `())]  
    )
  )

(define (var-occurs-free? x y)
  (match y
    [`(lambda (,var) ,body)
     (cond [(eqv? var x) #f]
           [else (var-occurs-free? x body)]
           )
     ]
    [`(,rator ,rand) (or (var-occurs-free? x rator) (var-occurs-free? x rand))]
    [`,z (eqv? x z)]  
    )
  )

(define (var-occurs-bound? x y )
  (match y
    [`(lambda (,var) ,body)
     (cond
       [(memv x (vars y))
        (cond
          [(eqv? x var) #t]                          
          [else (var-occurs-bound? x body)]
          )
        ] 
       [else #f]
       )
     ]                                  
    [`(,rator ,rand) (or (var-occurs-bound? x rator) (var-occurs-bound? x rand))]
    [`,z #f]
    )
  )

(define (unique-free-vars x)
  (match x
    [`(lambda (,y) ,body) (remv y (unique-free-vars body))]
    [`(,rator ,rand) (union (unique-free-vars rator) (unique-free-vars rand))]
    [else (list x)]
    )
  )

(define (unique-bound-vars x)
  (match x
    [`(lambda (,y) ,body)
     (cond
       [(memv y (unique-vars body)) (cons y (unique-bound-vars body))]   
       [else (unique-bound-vars body)]
       )
     ]
    [`(,rator ,rand) (union (unique-bound-vars rator) (unique-bound-vars rand))]
    [else `()]
    )
  )

(define (lex x ls)
  (match x
    [`(lambda (,y) ,body)  `(lambda ,(lex body (cons y ls))) ]                   
    [`(,rator ,rand) (list (lex rator ls) (lex rand ls))]
    [`,z (let ([i (index-of ls z)])                      
           (cond
             [(eqv? i #f) ]            
             [else (cons `var (list i))]))]                
    )
  )   