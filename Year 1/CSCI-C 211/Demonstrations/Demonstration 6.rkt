;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Demonstration 6|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; A Points is one of:
; - (make-no-points)
; - (make-lots Posn Points)

(define-struct lots (p ps))

(define-struct no-points ())

; add-a-point : Posn Points -> Points
(define (add-a-point  p ps) (make-lots p ps))

(check-expect (add-a-point (make-posn 1 2) (make-no-points))
              (make-lots (make-posn 1 2) (make-no-points)))
; add-to-no-points : Posn NoPoints -> OnePoint
; create a bigger set of points
(define (add-to-no-points p ps)
  (make-lots p ps))

; add-to-lots : Posn LotsOfPoints -> Points
(define (add-to-lots p ps)
  (make-lots p ps))

; count-points : Points -> Number
; count how many total posns in the given Points
(define (count-points ps)
  (cond
    [(no-points?  ps) 0]
    [(lots? ps)
     (+ 1 (count-points (lots-ps ps)))]))

(define (process-points ps)
  (cond [(no-points? ps) ...]
        [(lots? ps) (place-image (circle 5 "outline" "blue")
                    (lots-p ps)
                    (process-points (lots-ps ps)))]))

(check-expect (count-points (make-no-points)) 0)
(check-expect (count-points (make-lots (make-posn 1 2)
                                       (make-lots
                                        (make-posn 3 4) (make-no-points))))
              2)

; draw-points : Points -> Image
; draw all the given points on an empty scene
(define (draw-points ps)
  (cond [(no-points? ps) (empty-scene 100 100)]
        [(lots? ps) (place-image
                    (circle 5 "outline" "blue")
                    (posn-x (lots-p ps))
                    (posn-y (lots-p ps))
                    (draw-points (make-no-points)))]))

(check-expect (draw-points (make-no-points))
              (empty-scene 100 100))
(check-expect (draw-points (make-lots
                            (make-posn 50 50)
                            (make-no-points)))
              (place-image (circle 5 "outline" "blue") 50 50 (empty-scene 100 100)))

; add-point : Points Number Number MouseEvent-> Points
; add the given coordinates
(define (add-point ps x y me)
  (make-lots (make-posn x y) ps))
(big-bang (make-no-points)
 [to-draw draw-points]
 [on-mouse add-point])
