#lang racket

(require "mk.rkt")
(require "numbers.rkt")

;; Part I Write the answers to the following problems using your
;; knowledge of miniKanren.  For each problem, explain how miniKanren
;; arrived at the answer.  You will be graded on the quality of your
;; explanation; a full explanation will require several sentences.

;; 1 What is the value of 

(run 2 (q)
     (== 5 q)
     (conde
      [(conde 
        [(== 5 q)
         (== 6 q)])
       (== 5 q)]
      [(== q 5)]))

; The function above returns ((5)).
; The "2" in (run 2 ...) represents the number of answers to be returned
; The (q) in (run 2 (q) ...) represents the value to be returned, in this case, the value of q.
; (== 5 q) is the goal, and it associates q with 5.
; The outer conde has two clauses, the first of which is a nested conde,
; and the second of which is an application of (== q 5)
; The inner conde fails because the value of q is 5, and associating q with 6 conflicts with the previous declaration.
; The second clause is a success, as the value of q remains 5. Thus, the value of q is returned.
; Only one value of q is returned instead of 2 because q is only associated with a number one time, at the beginning.

;; 2 What is the value of
(run 1 (q) 
     (fresh (a b) 
            (== `(,a ,b) q)
            (absento 'tag q)
            (symbolo a)))

; The function above returns (((_0 _1))).
; Again, the "1" represents the number of answers to be returned, forming a list of 1 element
; In this example, the goal associates q with the pair of ,a and ,b.
; The second goal restrains 'tag from being inside q or a part of ,a or ,b.
; The third goal claims ,a is bound to be a symbol. 
; The first entry of the answer is _0 because ,a is unbound
; and the second entry is _1 because ,b is bound. 

;; 3 What do the following miniKanren constraints mean?
;; a ==         Associates a variable with a value
;; b =/=        Prevents a variable from being assigned to a specific value.
;; c absento    Forces a variable to be absent from another variable.
;; d numbero    Checks if the given value is a number
;; e symbolo    Checks if the given value is a symbol

;; Part II goes here.

; Essential functions in mk form
(define conso
  (lambda (a b p)
    (== `(,a . ,b) p)))
(define caro
  (lambda (p a)
    (fresh (d)
           (conso a d p))))
(define cdro
  (lambda (p d)
    (fresh (a)
           (conso a d p))))
(define nullo
  (lambda (ls)
    (== ls '())))

; Part 2

(define assoc
  (lambda (x ls)
    (match-let* ((`(,a . ,d) ls)
                 (`(,aa . ,da) a))
      (cond
        ((equal? aa x) a)
        ((not (equal? aa x)) (assoc x d))))))

(define assoco
  (lambda (x ls out)
    (fresh (a d)
           (conso a d ls)
           (fresh (aa ad)
                  (conso aa ad a)
                  (conde
                   [(== aa x)
                    (== out a)]
                   [(=/= aa x) 
                    (assoco x d out)])))))

(define reverse
  (lambda (ls)
    (cond
      ((equal? '() ls) '())
      (else
       (match-let* ((`(,a . ,d) ls)
                    (res (reverse d)))
         (append res `(,a)))))))

(define reverseo
  (lambda (ls out)
    (conde
     [(nullo ls) (== out '())]
     [(fresh (a d out^)
             (conso a d ls)
             (reverseo d out^)
             (appendo out^ `(,a) out)
             )])))

(define stutter
  (lambda (ls)
    (cond
      ((equal? '() ls) '())
      (else 
       (match-let* ((`(,a . ,d) ls)
                    (res (stutter d)))
         `(,a ,a . ,res))))))

(define stuttero
  (lambda (ls out)
    (conde
     [(nullo ls) (== out '())]
     [(fresh (a d res)
             (conso a d ls)
             (== out `(,a ,a . ,res))
             (stuttero d res))])))

