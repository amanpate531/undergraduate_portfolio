;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Demonstration 9|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; A world is a ListofAlien

; A ListofAlien is one of:
; - empty
; - (cons Posn ListofAlien)

; move-aliens : ListofAlien -> ListofAlien
; move all the aliens down five positions
(define (move-aliens loa)
  (cond [(empty? loa) empty]
        [else (cons (move-alien (first loa))
                    (move-aliens (rest loa)))]))
(check-expect (move-aliens empty) empty)
(check-expect (move-aliens
               (list (make-posn 3 4) (make-posn 4 5)))
              (list (make-posn 3 -1) (make-posn 4 0)))
               
; move-alien : Posn -> Posn
; subtracts five from y coordinate of posn, moves alien down by five
(define (move-alien p)
  (make-posn (posn-x p) (- (posn-y p) 5)))
(check-expect (move-alien (make-posn 43 45)) (make-posn 43 40))

(define SCREEN 400)

; random-alien : Number -> Posn
; places the alien at a random position at the given height
(define (random-alien n) (make-posn (random SCREEN)
                                    n))
(check-random (random-alien 400)
              (make-posn (random SCREEN)
                         400))

; A NaturalNumber is one of:
; - 0
; - (add1 NaturalNumber)
; random-aliens : Number Number -> ListofAlien
; create count many aliens all at height
(define (random-aliens height count)
  (cond [(zero? count) empty]
        [else
         (cons (random-alien height)
         (random-aliens height (sub1 count)))]))
(check-random (random-aliens 400 0) empty)
(check-random (random-aliens 400 2)
              (list (make-posn (random 400) 400)
                    (make-posn (random 400) 400)))

(define BACKGROUND (rectangle 400 400 "solid" "black"))
(define ALIEN (circle 10 "solid" "green"))
; draw-aliens : ListofAlien -> Image
; draw the aliens from the top of the screen
(define (draw-aliens loa)
  (cond [(empty? loa) BACKGROUND]
        [else (draw-alien (first loa)
                          (draw-aliens (rest loa)))]))
(check-expect (draw-aliens empty) BACKGROUND)
(check-expect (draw-aliens (list (make-posn 50 50)))
              (place-image ALIEN 50 350 BACKGROUND))
(check-expect (draw-aliens (list (make-posn 40 40) (make-posn 45 45)))
              (overlay (place-image ALIEN 40 -10 BACKGROUND)
                       (place-image ALIEN 45 5 BACKGROUND)))
              
              

; draw-alien : Posn Image -> Image
; draw the alien at the specified location with reverse coords
(define (draw-alien p img)
  (place-image ALIEN
               (posn-x p) (- 400 (posn-y p))
               img))
(check-expect (draw-alien (make-posn 50 50) (empty-scene 500 500))
              (place-image ALIEN
                           50 350
                           (empty-scene 500 500)))

(big-bang (random-aliens 400 20)
          [on-tick move-aliens 1]
          [to-draw draw-aliens])