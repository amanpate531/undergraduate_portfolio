;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Lab 4|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct cupcake (frosting))
(define-struct pie (filling slices))

;(make-cupcake "chocolate")
;(make-cupcake "vanilla")

;(define (dessert f s n)
;  (cond [(string=? f "chocolate") (make-cupcake "chocolate")]
;        [(string=? f "vanilla") (make-cupcake "vanilla")]
;        [else (make-pie ... ...)]))

(define-struct dessert (f s n))

(define (process-dessert dessert)
  (cond [(string=? (dessert-f dessert) "chocolate") (make-cupcake "chocolate")]
        [(string=? (dessert-f dessert) "vanilla") (make-cupcake "vanilla")]
        [else (make-pie (dessert-s dessert) (dessert-n dessert))]))

(define apple-pie (process-dessert (make-dessert "red" "apple" 12)))
(define chocolate-cupcake (process-dessert (make-dessert "chocolate" "apple" 12)))
(define vanilla-cupcake (process-dessert (make-dessert "vanilla" "apple" 12)))

; desert-calories : String String Number -> Number
; Takes a frosting, filling and number and displays a calorie count

(define (dessert-calories dessert)
  (cond [(string=? (dessert-f dessert) "chocolate") 150]
        [(string=? (dessert-f dessert) "vanilla") 125]
        [else (* (dessert-n dessert) 175)]))

(check-expect (dessert-calories (make-dessert "chocolate" "pumpkin" 12)) 150)
(check-expect (dessert-calories (make-dessert "vanilla" "pumpkin" 12)) 125)
(check-expect (dessert-calories (make-dessert "red" "pumpkin" 12)) 2100)

; A Case is one of:
; - Empty
; - (make-case dessert case)

; A Num is one of:
; - 0
; - 1
; - 2
; - etc.

; A Frosting is one of:
; - "chocolate"
; - "vanilla"

; A Dessert is one of:
; - (make-cupcake Frosting)
; - (make-pie String Number)

(define-struct case (dessert case))

(define x (make-case (make-dessert "apple" "apple" 23) empty))
(define y (make-case (make-dessert "chocolate" "red" 12) x))
(define z (make-case (make-dessert "red" "pumpkin" 1) y))

(define (process-case case n)
  (cond [(equal? n empty) x]
        [else (process-case x n)]))


; total-calories : Case -> Number
(define (total-calories case)
  (+ (dessert-calories (make-dessert (dessert-f (case-dessert (process-case case (process-case x empty))))
                                  (dessert-s (case-dessert (process-case case (process-case x empty))))
                                  (dessert-n (case-dessert (process-case case (process-case x empty))))))
  (dessert-calories (make-dessert (dessert-f (case-dessert (process-case x empty)))
                                  (dessert-s (case-dessert (process-case x empty)))
                                  (dessert-n (case-dessert (process-case x empty)))))))

; A World is one of:
; - (make-empty-world)
; - (make-world x y)
(define-struct world (p ws))
(define-struct empty-world ())

; add-to-world : Posn WorldState -> WorldState
; adds a Posn to a collection of worlds
(define (add-to-world p ws)
  (cond
    [(empty-world? ws) (make-world p (make-empty-world))]
    [(world? ws) (add-to-world (world-p ws) (world-ws ws))]))

(check-expect (add-to-world (make-posn 3 4) (make-empty-world))
              (make-world (make-posn 3 4) (make-empty-world)))
(check-expect (add-to-world (make-posn 8 4) (make-world (make-posn 3 4)
                                                        (make-empty-world)))
              (add-to-world (make-posn 8 4) (make-world (make-posn 3 4)
                                                        (make-empty-world))))

; draw-world : WorldState -> Image
; 
(define (draw-world ws)
  (cond
    [(empty-world? ws) BACKGROUND]
    [(world? (make-world (make-posn 0 0) ws)) (place-image
                  CIRCL
                  (posn-x (world-p ws))
                  (posn-y (world-p ws))
                  (draw-world (world-ws ws)))]))

(check-expect (draw-world world1)
              (place-image
               CIRCL
               3
               4
               (draw-world (make-empty-world))))
                         
(define BACKGROUND (empty-scene 400 400 "white"))
      
(define CIRCL (circle 7 "outline" "blue"))

(define world1
  (make-world (make-posn 3 4) (make-empty-world)))

; 3 Worlds Examples
(make-empty-world)
(make-world (make-posn 3 4) (make-empty-world))
(make-world (make-posn 4 5)
            (make-world (make-posn 2 4) (make-empty-world)))

; handle-mouse : WorldState Number Number MouseEvent -> WorldState
; makes a world with posn x,y and worldstate when the mouse is pressed down
(define (handle-mouse ws x y me)
  (cond [(string=? me "button-down")
         (make-world (make-posn x y) ws)]
        [else ws]))

(check-expect (handle-mouse (make-empty-world) 10 20 "button-down")
              (make-world (make-posn 10 20) (make-empty-world)))
(check-expect (handle-mouse (make-empty-world) 10 20 "button-up")
              (make-empty-world))

; move-world : WorldState -> Image
; takes the speci
(define (move-world ws)
 (cond
   [(world? ws) (place-image
                  CIRCL
                  (+ 3 (posn-x (world-p ws)))
                  (- (posn-y (world-p ws)) 3)
                  (draw-world (world-ws ws)))]
   [else (make-world (make-posn 20 20) ws)]))

(check-expect (move-world world1) (place-image
                                   CIRCL
                                   6
                                   1
                                   (draw-world (world-ws world1))))
(check-expect (move-world (make-empty-world))
              (make-world (make-posn 20 20) (make-empty-world)))
(big-bang (make-empty-world)
          [on-mouse handle-mouse]
          [to-draw draw-world])

;(big-bang world1
;          [on-mouse handle-mouse]
;          [to-draw draw-world]
;          [on-tick move-world])

          