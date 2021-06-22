;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Assignment 1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define tri (circle 10 "solid" "blue"))
  
(define p (above tri
       (beside tri
               tri)))

(define o (above p
       (beside p
               p)))

(above o
       (beside o
               o))

(define l (above (beside tri
               tri)
       tri))

(define c (above (beside l
               l)
       l))

(above (beside c
               c)
       c)