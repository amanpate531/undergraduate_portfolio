;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Demonstration 5 Part 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Shape is one of:
; - (make-circl Number String)
; - (make-sq Number String)
; - (make-tri Number String)
; - (make-rect Number Number String)
(define-struct circl (radius color))
(define-struct sq (side color))
(define-struct tri (height color))
(define-struct rect (length width color))

; draw the specified shape as an image
; draw: Shape -> Image

(define (draw s)
  (cond
    [(circl? s) (circle (circl-radius s) "solid" (circl-color s))]
    [(sq? s) (square (sq-side s) "solid" (sq-color s))]
    [(tri? s) (triangle (tri-height s) "solid" (tri-color s))]
    [else (rectangle (rect-length s) (rect-width s) "solid" (rect-color s))]))

(check-expect (draw (make-circl 32 "red")) (circle 32 "solid" "red"))
(check-expect (draw (make-sq 10 "red")) (square 10 "solid" "red"))
(check-expect (draw (make-tri 32 "green")) (triangle 32 "solid" "green"))
(check-expect (draw (make-rect 30 40 "red")) (rectangle 30 40 "solid" "red"))

(require 2htdp/image)
(require 2htdp/universe)


; grow : Shape -> Shape
; make the given shape larger

(define (grow s)
  (cond
    [(circl? s) (make-circl (+ 1 (circl-radius s)) (circl-color s))]
    [(sq? s) (make-sq (+ 1 (sq-side s)) (sq-color s))]
    [(tri? s) (make-tri (+ 1 (tri-height s)) (tri-color s))]
    [else (make-rect (+ 1 (rect-length s)) (+ 1 (rect-width s)) (rect-color s))]))

(check-expect (grow (make-sq 10 "red"))
              (make-sq 11 "red"))
(check-expect (grow (make-rect 10 5 "green"))
              (make-rect 11 6 "green"))
(check-expect (grow (make-tri 10 "red"))
              (make-tri 11 "red"))
(check-expect (grow (make-circl 10 "red"))
              (make-circl 11 "red"))

; key : Shape KeyEvent -> Shape
; change to the next shape

(define (key s ke)
  (cond
    [(circl? s) (make-tri (circl-radius s) "red")]
    [(sq? s) (make-circl (sq-side s) "green")]
    [(tri? s) (make-rect (tri-height s) (* 1.5 (tri-height s)) "purple")]
    [else (make-sq (rect-length s) "yellow")]))

(check-expect (key (make-circl 10 "green") "a")
              (make-tri 10 "red"))
(check-expect (key (make-rect 50 75 "purple") " ")
              (make-sq 50 "yellow"))

(big-bang (make-tri 100 "green")
          [to-draw draw]
          [on-tick grow]
          [on-key key])