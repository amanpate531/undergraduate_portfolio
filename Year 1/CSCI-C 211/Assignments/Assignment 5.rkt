;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Assignment 5|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A Pair is a group of two numbers representing x and y coordinates

(define-struct pair (x y))

; A Pairs is one of:
; - (make-no-pairs)
; - (make-some-pairs Pair Pairs)

(define-struct no-pairs ())
(define-struct some-pairs (p ps))

; process-pair : Pair -> ???
(define (process-pair p)
  (... (pair-x p) (pair-y p) ...))

; process-pairs : Pairs -> ???
(define (process-pairs ps)
  (cond
    [(no-pairs? ps) ...]
    [else (process-pairs (some-pairs-ps ps))]))

; draw-pairs : Pairs -> Image
; renders a circle with radius 10 at location (x,y) given a Pairs

(define (draw-pairs ps)
  (cond
    [(no-pairs? ps) (empty-scene 200 200 "white")]
    [(some-pairs? ps) (place-image (circle 10 "solid" "red")
                                   (pair-x (some-pairs-p ps))
                                   (pair-y (some-pairs-p ps))
                                   (draw-pairs (some-pairs-ps ps)))]))
  

(define ps1 (make-some-pairs (make-pair 100 100) (make-no-pairs)))

(check-expect (draw-pairs ps1)
              (place-image (circle 10 "solid" "red")
               100
               100
               (empty-scene 200 200 "white")))
(check-expect (draw-pairs (make-no-pairs))
              (empty-scene 200 200 "white"))
; any-paint : Pairs x y MouseEvent -> Pairs
; creates a new Pairs given a Pairs x y and mouseevent

(define (any-paint ps x y me)
  (cond
    [(mouse-event? me)
     (cond
    [(no-pairs? ps) (make-some-pairs (make-pair x y) (make-no-pairs))]
    [(some-pairs? ps) (make-some-pairs (make-pair x y) ps)])]
    [else ps]))

(check-expect (any-paint ps1 4 5 "button-up")
              (make-some-pairs
               (make-pair 4 5)
               (make-some-pairs (make-pair 100 100) (make-no-pairs))))
(check-expect (any-paint (make-no-pairs) 8 89 "button-down")
              (make-some-pairs
               (make-pair 8 89)
               (make-no-pairs)))
(check-expect (any-paint (make-no-pairs) 8 89 "ewd")
              (make-no-pairs))

; any-undo : Pairs KeyEvent -> Pairs
; removes the most recent addition to Pairs when given a KeyEvent

(define (any-undo ps ke)
  (cond
    [(no-pairs? ps) (make-no-pairs)]
    [(some-pairs? (some-pairs-ps ps)) (some-pairs-ps ps)]
    [(no-pairs? (some-pairs-ps ps)) (make-no-pairs)]))

(check-expect (any-undo ps1 "a")
              (make-no-pairs))
(check-expect (any-undo (make-no-pairs) "a")
              (make-no-pairs))
(check-expect (any-undo (make-some-pairs (make-pair 3 4) ps1) "a")
              ps1)

; run-any : Pairs -> Image
; uses a Pairs as the initial condition for a big-bang function

(define (run-any ps)
  (big-bang ps
            [on-mouse any-paint]
            [on-key any-undo]
            [to-draw draw-pairs]))

; paint : Pairs x y MouseEvent -> Pairs
; adds (make-pair x y) to Pairs if MouseEvent is "button-down" or "drag"

(define (paint ps x y me)
  (cond
    [(or (string=? me "button-down") (string=? me "drag"))
     (cond
    [(no-pairs? ps) (make-some-pairs (make-pair x y) (make-no-pairs))]
    [(some-pairs? ps) (make-some-pairs (make-pair x y) ps)])]
    [else ps]))

(check-expect (paint ps1 5 2 "button-down")
              (make-some-pairs (make-pair 5 2) ps1))
(check-expect (paint ps1 5 2 "drag")
              (make-some-pairs (make-pair 5 2) ps1))
(check-expect (paint ps1 5 2 "red")
              ps1)
(check-expect (paint (make-no-pairs) 5 3 "button-down")
              (make-some-pairs (make-pair 5 3) (make-no-pairs)))

; undo : Pairs KeyEvent -> Pairs
; removes most recent pair from Pairs when "z" is pressed

(define (undo ps ke)
  (cond
    [(string=? ke "z")
     (cond
    [(no-pairs? ps) (make-no-pairs)]
    [(some-pairs? (some-pairs-ps ps)) (some-pairs-ps ps)]
    [(no-pairs? (some-pairs-ps ps)) (make-no-pairs)])]
    [else ps]))

(check-expect (undo ps1 "z")
              (make-no-pairs))
(check-expect (undo ps1 "r")
              ps1)
(check-expect (undo (make-no-pairs) "z")
              (make-no-pairs))
(check-expect (undo (make-some-pairs
                     (make-pair 3 4)
                     ps1) "z")
              ps1)

; run : Pairs -> Image
; inputs a Pairs as the initial condition of a big-bang function

(define (run ps)
  (big-bang ps
            [on-mouse paint]
            [on-key undo]
            [to-draw draw-pairs]))

; A SolarObject is one of:
; - (make-planet n SolarObject)
; - (make-sun (n))

(define-struct planet (n SO))
(define-struct sun ())

; process-solar-object : SolarObject -> ???
(define (process-solar-object SO)
  (cond
    [(planet? SO) (process-solar-object (planet-SO SO))]
    [(sun? SO) ...]))

; distance-of-solar-object : SolarObject -> Number
;  determines the distance from the outermost SO to the center of the solar system
(define (distance-of-solar-object SO)
  (cond
    [(planet? SO) (+ (planet-n SO)
                     (distance-of-solar-object (planet-SO SO)))]
    [(sun? SO) 0]))

(check-expect (distance-of-solar-object (make-sun)) 0)
(check-expect (distance-of-solar-object (make-planet 54 (make-sun))) 54)
(check-expect (distance-of-solar-object
               (make-planet 54
                            (make-planet 53
                                         (make-sun)))) 107)

; add-to-solar-object : SolarObject Number -> SolarObject
; adds a planet to the given SolarObject at the specified distance
(define (add-to-solar-object SO n)
  (make-planet n SO))

(check-expect (add-to-solar-object (make-sun) 34)
              (make-planet 34 (make-sun)))
(check-expect (add-to-solar-object (make-planet 34 (make-sun)) 25)
              (make-planet 25 (make-planet 34 (make-sun))))

; draw-solar-object : SolarObject -> Image
; draws a SolarObject on an empty scene
(define (draw-solar-object SO)
  (cond
    [(sun? SO) (place-image
                (circle 20 "solid" "yellow")
                100
                100
                (empty-scene 200 200 "white"))]
    [(planet? SO) (overlay
                   (circle (planet-n SO) "outline" "red")
                   (draw-solar-object (planet-SO SO)))]))

(check-expect (draw-solar-object (make-sun))
              (place-image
                (circle 20 "solid" "yellow")
                100
                100
                (empty-scene 200 200 "white")))
(check-expect (draw-solar-object
               (make-planet 40
                            (make-planet 50
                                         (make-planet 90 (make-sun)))))
              (overlay
               (circle 40 "outline" "red")
               (circle 50 "outline" "red")
               (circle 90 "outline" "red")
               (place-image
                (circle 20 "solid" "yellow")
                100
                100
                (empty-scene 200 200 "white"))))