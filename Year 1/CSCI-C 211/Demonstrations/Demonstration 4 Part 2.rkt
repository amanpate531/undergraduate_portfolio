;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Demonstration 4 Part 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct point [x y])

; make-point
; point-x
; point-y
; point?

; The corresponding data definition:
; A Point is a (make-pt Number Number)

; make-point : Number Number -> Point
; point-x : Point -> Number
; point-y : Point -> Number
; point? : Anything -> Boolean

; Eliminating after introducing a Point
(check-expect (point-x (make-point 3 4)) 3)
(check-expect (point-y (make-point 3 4)) 4)

; Introducing after eliminating a Point
(define pt (make-point 3 4))
(check-expect (make-point (point-x pt) (point-y pt)) pt)

; a general template for functions on a Point
; ... : Point -> ...
;(define (... p)
;  ... (point-x p) ... (point-y p) ...)

; euclid-norm : distance to the origin : Point -> Number
; calculate the Euclidean norm of a point
(check-expect (euclid-norm (make-point 3 4)) 5)
(check-expect (euclid-norm (make-point 5 12)) 13)

(define (euclid-norm p)
  (sqrt (+ (* (point-x p) (point-x p))
           (* (point-y p) (point-y p)))))

; Try with the Stepper
(euclid-norm pt)
