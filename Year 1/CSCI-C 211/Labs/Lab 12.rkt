;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lab 12|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Constants
(define WIDTH 800)
(define HEIGHT 160)
(define MT (empty-scene WIDTH HEIGHT))

; next-size : Number -> Number
; divides the given number by 2
(define (next-size s)
  (/ s 2))

(check-expect (next-size 30) 15)
; circles : Number Number Image -> Image
; places a circle of the given size at the given x-value on the given image
(define (circles x size scn)
  (cond [(< size 2) scn]
        [else (place-image (circle size "outline" "blue")
                           x
                           (/ HEIGHT 2)
                           (circles (+ size x (next-size size)) (next-size size) scn))]))

; next-size.v2 : Number -> Number
; divides the given number by 3/2
(define (next-size.v2 n)
  (/ n 1.3))

(check-expect (next-size.v2 13) 10)

; circles.v2 : Number Number Image -> Image
; places a circle of the given size at the given x-value on the given image
(define (circles.v2 x size scn)
  (cond [(<= size 2) scn]
        [else (place-image (circle size "outline" "blue")
                           x
                           (/ HEIGHT 2)
                           (circles.v2 (+ size x (next-size.v2 size)) (next-size.v2 size) scn))]))

; next-x : Number Number Number -> Number
; determines the next x-value of the spiral
(define (next-x x size ang)
  (+ x (* (cos ang) (+ (next-size size) size))))

; next-y : Number Number Number -> Number
; determines the next y-value of the spiral
(define (next-y y size ang)
  (+ y (* (sin ang) (+ (next-size size) size))))

(check-within (next-y 20 20 0) 20 0.01)
; next-angle : Number -> Number
; determines the next angle of the spiral
(define (next-angle ang)
  (+ ang (/ pi 8)))

(check-within (next-angle 0) (/ pi 8) 0.01)
; spiral : Number Number Number Number Image -> Image
; creates a spiral of circles using the given parameters and base case image
(define (spiral x y size ang scn)
  (cond [(<= size 2) scn]
        [else (place-image (circle size "outline" "blue")
                           x
                           y
                           (spiral (next-x x size ang)
                                   (next-y y size ang)
                                   (next-size size)
                                   (next-angle ang)
                                   scn))]))

; spiral.v2 : Number Number Number Number Image -> Image
; creates a spiral of circles using the given parameters and base case image
(define (spiral.v2 x y size ang scn)
  (cond [(> ang (* 2 pi)) scn]
        [else (place-image (circle size "outline" "blue")
                           x
                           y
                           (spiral.v2 (+ x (* (cos ang) (/ size 2)))
                                      (+ y (* (sin ang) (/ size 2)))
                                      size
                                      (next-angle ang)
                                      scn))]))

; put-line : Number Number Number Number String Image -> Image
; Put a line in the image starting at (x,y) len distance
;    in the given direction with the given color
(define (put-line x y ang len color scn)
  (place-image (line (* (cos ang) len)
                     (* (sin ang) len) color)
               (+ x (* (cos ang) (/ len 2)))
               (+ y (* (sin ang) (/ len 2)))
               scn))

; next-xbot : Number Number Number -> Number
; determines the next x-value of the bottom tree
(define (next-xbot x len ang)
  (+ x (* (cos ang) (/ len 3))))

; next-ybot : Number Number Number -> Number
; determines the next y-value of the bottom tree
(define (next-ybot y len ang)
  (+ y (* (sin ang) (/ len 3))))

; next-xtop : Number Number Number -> Number
; determines the next x-value of the top tree
(define (next-xtop x len ang)
  (+ x (* (cos ang) (* 2 (/ len 3)))))

; next-ytop : Number Number Number -> Number
; determines the next y-value of the top tree
(define (next-ytop y len ang)
  (+ y (* (sin ang) (* 2 (/ len 3)))))

; next-angtop : Number -> Number
; determines the next angle of the top tree
(define (next-angtop ang)
  (- ang (/ pi 3)))

; next-angbot : Number -> Number
; determines the next angle of the bottom tree
(define (next-angbot ang)
  (+ ang (/ pi 3)))

; next-len : Number -> Number
; determines the length of the next branch
(define (next-len len)
  (/ len 2))

; tree : Number Number Number Number String Image -> Image
; draws a tree using the given parameters
;(define (tree x y ang len color scn)
;  (cond [(< len 3) (put-line x y ang len "green" scn)]
;        [else (put-line x y ang len "brown"
;                        (put-line 

; koch : Number Number Number Number Number String Image -> Image
; draws a Koch Style Fractal using the given parameters
(define (koch x y ang len iter color scn)
  (cond [(= iter 0) scn]
        [else (put-line x y ang (/ len 3) color
                        (put-line (+ x (* (cos ang) (/ len (* 3 iter))))
                                  (- y (* (sin ang) (/ len (* 3 iter))))
                                  (+ ang (/ pi -3)) (/ len (* 3 iter)) color
                                  (put-line (+ x (* 2 (cos ang) (/ len (* 3 iter))))
                                            y
                                            (- ang (* 2 (/ pi 3))) (/ len (* 3 iter)) color
                                            (put-line (+ x (/ len (* 3 iter)) (* 2 (cos (/ pi 3)) (/ len (* 3 iter))))
                                                      y ang (/ len (* 3 iter)) color
                                                      (koch x y ang len (sub1 iter) color MT)))))]))