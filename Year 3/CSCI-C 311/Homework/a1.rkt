#lang racket
(provide (all-defined-out))

(define (countdown x)
  (cond
    [(zero? x) '(0 . ())]
    [else (cons x (countdown (sub1 x)))]
  )
)

(define (insertR x y ls)
  (cond
    [(null? ls) '()]
    [(not (eqv? x (car ls))) (cons (car ls) (insertR x y (cdr ls)))]
    [else (cons (car ls) (cons y (insertR x y (cdr ls))))]
  )
)

(define (remv-1st x ls)
  (cond
    [(null? ls) '()]
    [else
     (cond
       [(eqv? x (car ls)) (cdr ls)]
       [else (cons (car ls) (remv-1st x (cdr ls)))])
    ]
  )
)

(define (list-index-ofv? x ls)
  (cond
    [(eqv? (car ls) x) 0]
    [else (add1 (list-index-ofv? x (cdr ls)))]
  )
)

(define (filter p ls)
  (cond
    [(null? ls) '()]
    [(p (car ls)) (cons (car ls) (filter p (cdr ls)))]
    [else (filter p (cdr ls))]
  )
)

(define (zip ls1 ls2)
  (cond
    [(or (null? ls1) (null? ls2)) '()]
    [else (cons `(,(car ls1) . ,(car ls2)) (zip (cdr ls1) (cdr ls2)))]
  )
)

(define (map p ls)
  (cond
    [(null? ls) '()]
    [else (cons (p (car ls)) (map p (cdr ls)))]
  )
)

(define (append ls1 ls2)
  (cond
    [(null? ls1) ls2]
    [else (cons (car ls1) (append (cdr ls1) ls2))]
  )
)

(define (reverse ls)
  (cond
    [(null? ls) null]
    [else (append (reverse (cdr ls)) `(,(car ls)))]
  )
)

(define (fact x)
  (cond
    [(zero? x) 1]
    [else (* x (fact (sub1 x)))]
  )
)

(define (memv x ls)
  (cond
    [(null? ls) '#f]
    [(eqv? x (car ls)) ls]
    [else (memv x (cdr ls))]
  )
)

(define (fib n)
  (cond
    [(zero? n) 0]
    [(zero? (sub1 n)) 1]
    [else (+ (fib (sub1 n)) (fib (sub1 (sub1 n))))]
  )
)

#| 13. ((w x) y (z)) == (y . (w . (x)) . (z . ()))|#

(define (binary->natural ls)
  (cond
    [(null? ls) 0]
    [else (+ (car ls) (* 2 (binary->natural (cdr ls))))]
  )
)

(define (minus x y)
  (cond
    [(zero? y) x]
    [else (minus (sub1 x) (sub1 y))]
  )
)

(define (div x y)
  (cond
    [(zero? x) 0]
    [else (add1 (div (minus x y) y))]
  )
)

(define (append-map p ls)
  (cond
    [(null? ls) '()]
    [else (append (car (map p ls)) (append-map p (cdr ls)))]
  )
)

(define (contains? x ls)
  (cond
    [(null? ls) #f]
    [(eqv? (car ls) x) #t]
    [else (contains? x (cdr ls))]
  )
)

(define (set-difference s1 s2)
  (cond
    [(null? s1) '()]
    [(contains? (car s1) s2) (set-difference (cdr s1) s2)]
    [else (cons (car s1) (set-difference (cdr s1) s2))]
  )
)

(define (powerset ls)
  (cond
    [(null? ls) '(())]
    [else (append (powerset (cdr ls))
                  (map (lambda (set) (cons (car ls) set)) (powerset (cdr ls))))]
  )
)

(define (single-product x s)
  (cond
    [(null? s) '()]
    [else (cons (cons x (cons (car s) '())) (single-product x (cdr s)))]
  )
)

(define (cartesian-product ls)
  (cond
    [(null? (car ls)) '()]
    [else (append (single-product (car (car ls)) (car (cdr ls))) (cartesian-product (list (cdr (car ls)) (car (cdr ls)))))]
  )
)