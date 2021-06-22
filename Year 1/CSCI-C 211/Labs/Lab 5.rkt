;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Lab 5|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A PosnList is one of:
;  - empty
;  - (cons (make-posn Number Number) PosnList)
; A Posn is (make-posn Number Number)
; Note: the posn structure is defined in the Beginning Student Language,
; and looks like:
; (define-struct posn (x y))

(define (process-posn pl)
  (cond [(empty? pl) ...]
        [else (...
              (posn-x (first pl))
              (posn-y (first pl))
              (process-posn (rest pl)))]))
    
(define pl1 (cons (make-posn (- 0 3) 2) empty))
(define pl2 empty)
(define pl3 (cons (make-posn 3 2) (cons (make-posn 3 55) empty)))

; many-positive : PosnList -> Boolean
; determines if all x-coordinates of posns in PosnList are positive

(define (many-positive? pl)
  (cond [(empty? pl) true]
        [else
         (cond [(positive? (posn-x (first pl))) (many-positive? (rest pl))]
               [else false])]))

(check-expect (many-positive? pl1) false)
(check-expect (many-positive? pl2) true)
(check-expect (many-positive? pl3) true)

; draw : PosnList -> Image
; takes all the posns from a PosnList and creates an image
;(define (draw pl)
;  (cond [(empty? pl) (empty-scene 200 200)]
;        [else
;         (cond [(empty? (rest pl)) (place-image
;                                   (circle 10 "solid" "red")
;                                   (posn-x (first pl))
;                                   (posn-y (first pl))
;                                   (empty-scene 200 200))]
;               [else (overlay (place-image
;                                   (circle 10 "solid" "red")
;                                   (posn-x (first pl))
;                                   (posn-y (first pl))
;                                   (empty-scene 200 200))
;                              (draw (rest pl)))])]))

;(check-expect (draw pl2) (empty-scene 200 200))
;(check-expect (draw pl1) (place-image
;                                   (circle 10 "solid" "red")
;                                   -3
;                                   2
;                                   (empty-scene 200 200)))
;(check-expect (draw pl3) (overlay (place-image
;                                   (circle 10 "solid" "red")
;                                   3
;                                   2
;                                   (empty-scene 200 200))
;                                  (place-image
;                                   (circle 10 "solid" "red")
;                                   3
;                                   55
;                                   (empty-scene 200 200))))

; move : PosnList -> PosnList
; adds 1 to the y coordinate of each posn in PosnList

(define (move pl)
  (cond [(empty? pl) pl]
        [else
         (cond [(empty? (rest pl)) (cons (make-posn (posn-x (first pl))
                                                    (add1 (posn-y (first pl)))) empty)]
               [else (cons (make-posn (posn-x (first pl))
                                      (add1 (posn-y (first pl)))) (move (rest pl)))])]))

(check-expect (move pl1) (cons (make-posn -3 3) empty))
(check-expect (move pl2) empty)
(check-expect (move pl3) (cons (make-posn 3 3) (cons (make-posn 3 56) empty)))

; add : PosnList KeyEvent -> PosnList
; adds one posn to a PosnList after a KeyEvent

(define (add pl ke)
  (cons (make-posn (random 200) (random 200)) pl))

(check-random (add pl1 "h") (cons (make-posn (random 200) (random 200)) pl1))

;(big-bang pl1
;          [on-key add]
;          [to-draw draw]
;          [on-tick move])

; A ColorPosn is a (make-colorposn Posn Color)
(define-struct colorposn (p c))

; A ColorPosnList is one of:
; - empty
; - (cons (make-colorposn Posn Color) ColorPosnList)
(define cpl1 (cons (make-colorposn (make-posn -3 2)
                                   (make-color (random 255)
                                               (random 255)
                                               (random 255))) empty))
(define cpl2 empty)
(define cpl3 (cons (make-colorposn (make-posn 3 2)
                                   (make-color (random 255)
                                               (random 255)
                                               (random 255)))
                                   (cons (make-colorposn (make-posn 3 55)
                                               (make-color (random 255)
                                                           (random 255)
                                                           (random 255)))
                                         empty)))
(define (draw-cpl cpl)
  (cond [(empty? cpl) (empty-scene 200 200)]
        [else
         (cond [(empty? (rest cpl)) (place-image
                                   (circle 10 "solid" (make-color
                                                       (random 255)
                                                       (random 255)
                                                       (random 255)))
                                   (posn-x (colorposn-p (first cpl)))
                                   (posn-y (colorposn-p (first cpl)))
                                   (empty-scene 200 200))]
               [else (overlay (place-image
                                   (circle 10 "solid" (make-color
                                                       (random 255)
                                                       (random 255)
                                                       (random 255)))
                                   (posn-x (colorposn-p (first cpl)))
                                   (posn-y (colorposn-p (first cpl)))
                                   (empty-scene 200 200))
                              (draw-cpl (rest cpl)))])]))

(check-random (draw-cpl cpl1)
              (place-image
                                   (circle 10 "solid" (make-color
                                                       (random 255)
                                                       (random 255)
                                                       (random 255)))
                                   -3
                                   2
                                   (empty-scene 200 200)))
(check-expect (draw-cpl cpl2)
              (empty-scene 200 200))
(check-random (draw-cpl cpl3)
              (overlay (place-image
                                   (circle 10 "solid" (make-color
                                                       (random 255)
                                                       (random 255)
                                                       (random 255)))
                                   3
                                   2
                                   (empty-scene 200 200))
                       (place-image
                                   (circle 10 "solid" (make-color
                                                       (random 255)
                                                       (random 255)
                                                       (random 255)))
                                   3
                                   55
                                   (empty-scene 200 200))))

(define (move-cpl cpl)
  (cond [(empty? cpl) cpl]
        [else
         (cond [(empty? (rest cpl)) (cons (make-colorposn (make-posn (posn-x (colorposn-p (first cpl)))
                                                                     (add1 (posn-y (colorposn-p (first cpl)))))
                                                          (make-color (random 255)
                                                                      (random 255)
                                                                      (random 255)))
                                          empty)]
               [else (cons (make-colorposn (make-posn (posn-x (colorposn-p (first cpl)))
                                                      (add1 (posn-y (colorposn-p (first cpl)))))
                                           (make-color (random 255)
                                                       (random 255)
                                                       (random 255)))
                           (move-cpl (rest cpl)))])]))

(check-random (move-cpl cpl1)
              (cons (make-colorposn (make-posn -3 3) (make-color (random 255)
                                                                (random 255)
                                                                (random 255))) empty))
(check-expect (move-cpl cpl2) cpl2)
(check-random (move-cpl cpl3)
              (cons (make-colorposn (make-posn 3 3) (make-color (random 255)
                                                                (random 255)
                                                                (random 255)))
                    (cons (make-colorposn (make-posn 3 56) (make-color (random 255)
                                                                       (random 255)
                                                                       (random 255))) empty)))

(define (add-cpl cpl ke)
  (cons (make-colorposn (make-posn (random 200) (random 200))
                        (make-color (random 255)
                                    (random 255)
                                    (random 255))) cpl))

(check-random (add-cpl cpl2 "a")
              (cons (make-colorposn (make-posn (random 200) (random 200))
                                    (make-color (random 255)
                                                (random 255)
                                                (random 255))) empty))
                                                      
(big-bang cpl2
          [on-tick move-cpl]
          [on-key add-cpl]
          [to-draw draw-cpl])





