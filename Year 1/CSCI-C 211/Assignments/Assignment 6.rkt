;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Assignment 6|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define psn1 (make-posn 1 3))
(define psn2 (make-posn 5 6))
; posn-sum : Posn Posn -> Posn
; adds the components of two posns to form a new posn
(define (posn-sum p1 p2)
  (make-posn
   (+ (posn-x p1) (posn-x p2))
   (+ (posn-y p1) (posn-y p2))))

(check-expect (posn-sum psn1 psn2) (make-posn 6 9))

; posn-diff : Posn Posn -> Posn
; subtracts the second posn from the first posn
(define (posn-diff p1 p2)
  (make-posn
   (- (posn-x p1) (posn-x p2))
   (- (posn-y p1) (posn-y p2))))

(check-expect (posn-diff psn1 psn2) (make-posn -4 -3))

; posn-scale : Number Posn -> Posn
; multiplies components of a posn by a number
(define (posn-scale n p)
  (make-posn
   (* n (posn-x p))
   (* n (posn-y p))))

(check-expect (posn-scale 5 psn1) (make-posn 5 15))

; dist : Posn Posn -> Number
; computes the distance between two Posns
(define (dist p0 p1)
  (sqrt (+ (expt (- (posn-x p0) (posn-x p1)) 2)
           (expt (- (posn-y p0) (posn-y p1)) 2))))
 
(check-expect (dist psn1 psn2) 5)
(check-within (dist psn1 (make-posn 0 0)) (sqrt 10) 0.01)
 
; direction : Posn Posn -> Posn
; computes the direction of a Posn with respect to another Posn,
; representing direction as a Posn on the unit circle
(define (direction p p0)
  (posn-scale (/ 1 (dist p p0)) (posn-diff p p0)))
 
(check-within (direction (make-posn 400 400) (make-posn 200 200))
              (make-posn (/ (sqrt 2) 2) (/ (sqrt 2) 2)) .01)
(check-within (direction (make-posn 0 400) (make-posn 200 200))
              (make-posn (- 0 (/ (sqrt 2) 2)) (/ (sqrt 2) 2)) .01)
(check-within (direction (make-posn 400 0) (make-posn 200 200))
              (make-posn (/ (sqrt 2) 2) (- 0 (/ (sqrt 2) 2))) .01)
(check-within (direction (make-posn 0 0) (make-posn 200 200))
              (make-posn (- 0 (/ (sqrt 2) 2))
                         (- 0 (/ (sqrt 2) 2))) .01)
 
; approach-helper : Posn Posn Number -> Posn
; ...
(define (approach-helper p p0 s)
  (posn-sum p0 (posn-scale (- (dist p p0) s) (direction p p0))))

(check-within (approach-helper psn1 psn2 4)
              (make-posn 21/5 27/5) 0.01)
(check-within (approach-helper (make-posn 3 4) (make-posn 0 0) 4)
              (make-posn 3/5 4/5) 0.01)

; approach : Posn Posn Number -> Posn
; determines the new position after traveling s pixels per tick
(define (approach p p0 s)
  (cond [(> s (dist p p0)) p0]
        [else (approach-helper p p0 s)]))
 
(check-expect (approach psn1 psn2 6) psn2)
(check-expect (approach psn1 psn2 4) (approach-helper psn1 psn2 4))

(define pspeed 10)
(define zspeed 15)
(define background (empty-scene 400 400))
(define close-enough 3)
(define player (circle 10 "solid" "green"))
(define zombie (circle 10 "solid" "red"))

; pworld is (make-pworld Posn Posn)
(define-struct pworld (p g))

(define pw1 (make-pworld psn1 psn2))
; move-player : Pworld -> Pworld
; moves the player closer to the goal space
(define (move-player pworld)
  (make-pworld (approach (pworld-p pworld) (pworld-g pworld) 4)
               (pworld-g pworld)))

(check-within (move-player pw1)
               (make-pworld (make-posn 21/5 27/5)
                            psn2) 0.01)

; update-pgoal : Pworld Number Number MouseEvent -> Pworld
; changes the goal position according to the mouse position
(define (update-pgoal pworld x y me)
  (cond [(or (string=? me "button-down") (string=? me "drag"))
         (make-pworld (pworld-p pworld) (make-posn x y))]
        [else pworld]))

(check-expect (update-pgoal pw1 3 4 "drag")
              (make-pworld psn1 (make-posn 3 4)))
(check-expect (update-pgoal pw1 3 4 "a")
              pw1)

; draw-pworld : Pworld -> Image
; renders an image of a pworld
(define (draw-pworld pworld)
  (place-image
   player
   (posn-x (pworld-p pworld))
   (posn-y (pworld-p pworld))
   background))

(check-expect (draw-pworld pw1)
              (place-image
               player
               1 3
               background))

; run-pworld : Pworld -> BigBang
; inputs draw-pworld, update-pgoal, and move-player into big-bang
(define (run-pworld pworld)
  (big-bang pworld
            [on-tick move-player]
            [on-mouse update-pgoal]
            [to-draw draw-pworld]))

; A ListofZombies is one of:
; - empty
; - (cons Posn ListofZombies)

; helper-loz : Pworld ListofZombies -> Z-World
(define (helper-loz pworld loz)
  (make-zworld pworld loz))

; A zworld is (make-zworld Pworld ListofZombies)
(define-struct zworld (pworld loz))

; draw-zworld : Zworld -> Image
(define (draw-zworld zworld)
  (cond [(empty? (zworld-loz zworld))
         (draw-pworld (zworld-pworld zworld))]
        [else
         (cond [(empty? (rest (zworld-loz zworld)))
                (place-image
                 zombie
                 (posn-x (first (zworld-loz zworld)))
                 (posn-y (first (zworld-loz zworld)))
                 (draw-pworld (zworld-pworld zworld)))]
               [else (place-image
                 zombie
                 (posn-x (first (zworld-loz zworld)))
                 (posn-y (first (zworld-loz zworld)))
                 (draw-zworld (helper-loz pw1 (rest (zworld-loz zworld)))))])]))

(check-expect (draw-zworld (make-zworld pw1 empty)) (draw-pworld pw1))
(check-expect (draw-zworld (make-zworld pw1
                                        (cons (make-posn 4 5) empty)))
              (place-image zombie 4 5 (draw-pworld pw1)))
(check-expect (draw-zworld (make-zworld pw1
                                        (cons (make-posn 3 4)
                                              (cons (make-posn 4 5)
                                                    empty))))
              (place-image
               zombie
               3 4
               (place-image
                zombie
                4 5
                (draw-pworld pw1))))

; move-zombies : ListofZombies Posn -> ListofZombies
; moves all zombies towards specified Posn

(define (move-zombies loz p)
  (cond [(empty? loz) loz]
        [else
         (cond [(empty? (rest loz)) (approach (first loz) p 1)]
               [else (move-zombies (rest loz) p)])]))

(check-expect (move-zombies empty psn1) empty)
(check-within (move-zombies (cons (make-posn 4 5) empty) psn1)
              (approach (make-posn 4 5) psn1 1) 0.01)
(check-within (move-zombies (cons (make-posn 3 4) (cons (make-posn 4 5) empty)) psn1)
              (approach (make-posn 4 5) psn1 1) 0.01)

; move-everyone : Zworld -> Zworld
; moves player towards goal and zombies towards player
(define (move-everyone zworld)
  (move-player (zworld-pworld zworld)))

                              
              