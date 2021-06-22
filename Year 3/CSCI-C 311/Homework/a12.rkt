#lang racket

(require "monads.rkt")

(define return-maybe
  (lambda (a)
    `(Just ,a)))

(define bind-maybe
  (lambda (ma f)
    (cond
      [(eq? (car ma) 'Just) (f (cadr ma))]
      [(eq? (car ma) 'Nothing) '(Nothing)])))

(define fail
  (lambda ()
    '(Nothing)))

(define findf-maybe
  (lambda (p ls)
    (cond
      [(null? ls) (fail)]
      [else
       (bind-maybe (return-maybe (car ls))
                   (lambda (s)
                     (if (p (car ls))
                         (return-maybe (car ls))
                         (findf-maybe p (cdr ls)))))])))

(define (inj-writer a)
  (Writer '() a))

(define (tell msg)
  (Writer (list msg) (Unit)))

(define (bind-writer ma f)
  (match ma
    [(Writer la a) (match (run-writer (f a))
                     [(cons lb b) (Writer (append la lb) b)])]))

(define (run-writer ma)
  (match ma
    [(Writer log a) (cons log a)]))

(define partition-writer
  (lambda (p ls)
    (cond
      [(null? ls) (inj-writer '())]
      [(p (car ls)) (bind-writer (tell (car ls))
                                 (lambda (_)
                                   (partition-writer p (cdr ls))))]
      [else (bind-writer (inj-writer (car ls))
                         (run-writer (partition-writer p (cdr ls))))])))

(define reciprocal
  (lambda (a)
    (cond
      [(eqv? a 0) (fail)]
      [else (return-maybe (string-append "1/" (~a a)))])))

(define power
  (lambda (x n)
    (cond
      [(zero? n) (inj-writer 1)]
      [(zero? (sub1 n)) (inj-writer x)]
      [(odd? n) (* x (power x (sub1 n)))]
      [(even? n) (let ((nhalf (/ n 2)))
                   (let ((y (power x nhalf)))
                     (* y y)))])))