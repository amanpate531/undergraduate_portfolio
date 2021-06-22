;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Lab 8|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Exercise 1

; triple-lon : ListofNumber -> ListofNumber
; triples all elements of a ListofNumber
(define (triple-lon lon)
  (cond [(empty? lon) empty]
        [else (cons (* 3 (first lon)) (triple-lon (rest lon)))]))

(check-expect (triple-lon (list 2 3 4 5)) (list 6 9 12 15))
(check-expect (triple-lon empty) empty)

; half-lon : ListofNumber -> ListofNumber
; halves all elements of a ListofNumber
(define (half-lon lon)
  (cond [(empty? lon) empty]
        [else (cons (* 0.5 (first lon)) (half-lon (rest lon)))]))

(check-expect (half-lon empty) empty)
(check-expect (half-lon (list 2 4 6 8)) (list 1 2 3 4))

; mult-lon : Number ListofNumber -> ListofNumber
; multiplies all elements of the given ListofNumber by the given number
(define (mult-lon n lon)
  (cond [(empty? lon) empty]
        [else (cons (* n (first lon)) (mult-lon n (rest lon)))]))

(check-expect (mult-lon 3 (list 2 3 4 5)) (list 6 9 12 15))
(check-expect (mult-lon 3 empty) empty)
(check-expect (mult-lon 0.5 empty) empty)
(check-expect (mult-lon 0.5 (list 2 4 6 8)) (list 1 2 3 4))

; init-x-vel : Number Number -> Number
; calculates the initial x-velocity given init-speed and init-angle
(define (init-x-vel s a)
  (* s (cos a)))

(check-expect (init-x-vel 10 0) 10)
(check-expect (init-x-vel 0 10) 0)

; init-y-vel : Number Number -> Number
; calculates the initial y-velocity given init-speed and init-angle
(define (init-y-vel s a)
  (* s (sin a)))

(check-within (init-y-vel 10 (/ pi 2)) 10 0.01)
(check-expect (init-y-vel 0 10) 0)

; init-vel : [Number -> Number] Number Number -> Number
; calculates the initial velocity in either direction given the operation and two numbers
(define (init-vel op s a)
  (* s (op a)))

(check-expect (init-vel cos 10 0) 10)
(check-expect (init-vel cos 0 10) 0)
(check-within (init-vel sin 10 (/ pi 2)) 10 0.01)
(check-expect (init-vel sin 0 10) 0)

(define-struct leaf (weight))
(define-struct rod (lm ld rd rm))

; weight : Mobile -> Number
; calculates the total weight of a mobile
(define (weight m)
  (cond [(leaf? m) (leaf-weight m)]
        [else (+ (weight (rod-lm m))
                 (weight (rod-rm m)))]))

(check-expect (weight (make-leaf 2)) 2)
(check-expect (weight (make-rod (make-leaf 32) 3 3 (make-rod (make-leaf 2) 20 20 (make-leaf 3)))) 37)

; all-balanced : Mobile -> Boolean
; determines if the mobile is balanced everywhere
(define (all-balanced? m)
  (cond [(leaf? m) true]
        [(rod? m)
         (cond [(= (* (rod-ld m) (weight (rod-lm m)))
                   (* (rod-rd m) (weight (rod-rm m)))) true]
               [else false])]))

(check-expect (all-balanced? (make-leaf 2)) true)
(check-expect (all-balanced? (make-rod (make-leaf 30) 10 30 (make-leaf 9))) false)
(check-expect (all-balanced? (make-rod (make-leaf 30) 10 30 (make-leaf 10))) true)

; abstract-mobile : Mobile Op -> Number or Boolean
; applies the given function to the mobile
(define (abstract-mobile m op)
  (cond [(equal? op weight)
         (cond [(leaf? m) (leaf-weight m)]
               [else (+ (weight (rod-lm m))
                        (weight (rod-rm m)))])]
        [(equal? op all-balanced?)
         (cond [(leaf? m) true]
               [(rod? m)
                (cond [(= (* (rod-ld m) (weight (rod-lm m)))
                          (* (rod-rd m) (weight (rod-rm m)))) true]
                      [else false])])]))

(check-expect (abstract-mobile (make-leaf 2) weight) 2)
(check-expect (abstract-mobile (make-rod (make-leaf 32) 3 3 (make-rod (make-leaf 2) 20 20 (make-leaf 3))) weight) 37)
(check-expect (abstract-mobile (make-leaf 2) all-balanced?) true)
(check-expect (abstract-mobile (make-rod (make-leaf 30) 10 30 (make-leaf 9)) all-balanced?) false)
(check-expect (abstract-mobile (make-rod (make-leaf 30) 10 30 (make-leaf 10)) all-balanced?) true)

; short-string : String String -> String
; returns the shorter string
(define (short-string s1 s2)
  (cond [(= (min (string-length s1) (string-length s2)) (string-length s1)) s1]
        [else s2]))

(check-expect (short-string "as" "s") "s")
(check-expect (short-string "s" "as") "s")

; dist-posn : Posn -> Number
; calculates the distance from the posn to the origin
(define (dist-posn p)
  (sqrt (+ (expt (posn-x p) 2) (expt (posn-y p) 2))))

(check-expect (dist-posn (make-posn 3 4)) 5)

; close-posn : Posn Posn -> Posn
; returns the posn closer to the origin
(define (close-posn p1 p2)
  (cond [(= (min (dist-posn p1) (dist-posn p2)) (dist-posn p1)) p1]
        [else p2]))

(check-expect (close-posn (make-posn 3 4) (make-posn 0 0)) (make-posn 0 0))
(check-expect (close-posn (make-posn 3 4) (make-posn 10 321)) (make-posn 3 4))

; count-loi : ListofImages -> Number
; calculates the number of elements in a ListofImages
(define (count-loi loi)
  (cond [(empty? loi) 0]
        [else (add1 (count-loi (rest loi)))]))

(check-expect (count-loi empty) 0)
(check-expect (count-loi (list (circle 2 "solid" "green") (rectangle 2 3 "solid" "red"))) 2)

; short-loi : ListofImages ListofImages -> ListofImages
; returns the shorter ListofImages
(define (short-loi loi1 loi2)
  (cond [(= (min (count-loi loi1) (count-loi loi2)) (count-loi loi1)) loi1]
        [else loi2]))

(check-expect (short-loi empty (list (circle 2 "solid" "red"))) empty)
(check-expect (short-loi (list (circle 3 "solid" "green") (circle 4 "solid" "red"))
                         (list (circle 3 "solid" "blue")))
              (list (circle 3 "solid" "blue")))

; small-address : Address Address -> Address
; returns the address with the smaller house number
(define-struct address (n s c st))
(define (small-address a1 a2)
  (cond [(= (min (address-n a1) (address-n a2)) (address-n a1)) a1]
        [else a2]))

(check-expect (small-address (make-address 32 "hi" "Del" "IN")
                             (make-address 36 "hi" "Del" "IN"))
              (make-address 32 "hi" "Del" "IN"))
(check-expect (small-address (make-address 38 "hi" "Del" "IN")
                             (make-address 36 "hi" "Del" "IN"))
              (make-address 36 "hi" "Del" "IN"))

; abstract-two : X X [X X -> X]-> X
; applies the given function to the two given arguments
(define (abstract-two a1 a2 op)
  (cond [(equal? op short-string)
         (cond [(= (min (string-length a1) (string-length a2)) (string-length a1)) a1]
               [else a2])]
        [(equal? op close-posn)
         (cond [(= (min (dist-posn a1) (dist-posn a2)) (dist-posn a1)) a1]
               [else a2])]
        [(equal? op short-loi)
         (cond [(= (min (count-loi a1) (count-loi a2)) (count-loi a1)) a1]
               [else a2])]
        [(equal? op small-address)
         (cond [(= (min (address-n a1) (address-n a2)) (address-n a1)) a1]
               [else a2])]))

(check-expect (abstract-two "as" "s" short-string) "s")
(check-expect (abstract-two "s" "as" short-string) "s")
(check-expect (abstract-two (make-posn 3 4) (make-posn 0 0) close-posn) (make-posn 0 0))
(check-expect (abstract-two (make-posn 3 4) (make-posn 10 321) close-posn) (make-posn 3 4))
(check-expect (abstract-two empty (list (circle 2 "solid" "red")) short-loi) empty)
(check-expect (abstract-two (list (circle 3 "solid" "green") (circle 4 "solid" "red"))
                            (list (circle 3 "solid" "blue")) short-loi)
              (list (circle 3 "solid" "blue")))
(check-expect (abstract-two (make-address 32 "hi" "Del" "IN")
                            (make-address 36 "hi" "Del" "IN") small-address)
              (make-address 32 "hi" "Del" "IN"))
(check-expect (abstract-two (make-address 38 "hi" "Del" "IN")
                            (make-address 36 "hi" "Del" "IN") small-address)
              (make-address 36 "hi" "Del" "IN"))

; Book Exercise 239
; A [List X Y] is a structure:
; (cons X (cons Y '()))
; pair-two : [X , Y] X Y -> [List X Y]
; pairs the two given elements
(define (pair-two x y)
  (cond [(and (number? x) (number? y)) (cons x (cons y empty))]
        [(or (and (number? x) (and (string? y) (= (string-length y) 1)))
             (and (number? y) (and (string? x) (= (string-length x) 1))))
         (cons x (cons y empty))]
        [(or (and (string? x) (boolean? y))
             (and (string? y) (boolean? x)))
         (cons x (cons y empty))]))
        
(check-expect (pair-two "s" 3) (cons "s" (cons 3 empty)))
(check-expect (pair-two 3 "s") pn1s)
(check-expect (pair-two 3 4) pn)
(check-expect (pair-two "s" true) psb)
(check-expect (pair-two true "s") (cons true (cons "s" empty)))

(define pn (cons 3 (cons 4 empty)))
(define pn1s (cons 3 (cons "s" empty)))
(define psb (cons "s" (cons true empty)))

; count-lon : [Listof X] -> Number
; counts the number of elements in the given ListofNumber
;(define (count-lon lon)
;  (cond [(empty? lon) 0]
;        [else (add1 (count-lon (rest lon)))]))
(define (count-lon lon)
  (abstract-three count-lon lon))

(check-expect (count-lon (list 1 2 3 4 5)) 5)

; count-los : [Listof X] -> Number
; counts the number of elements in the given ListofString
;(define (count-los los)
;  (cond [(empty? los) 0]
;        [else (add1 (count-los (rest los)))]))
(define (count-los los)
  (abstract-three count-los los))

(check-expect (count-los (list "s" "f" "f" "r" "e")) 5)

; draw-pairs : ListofPosn -> Image
; draws a circle for each of the posns in the given ListofPosn
;(define (draw-pairs lop)
;  (cond [(empty? lop) (empty-scene 200 200)]
;        [else (place-image (circle 10 "solid" "blue")
;                           (posn-x (first lop))
;                           (posn-y (first lop))
;                           (draw-pairs (rest lop)))]))
(define (draw-pairs lop)
  (abstract-three draw-pairs lop))

(check-expect (draw-pairs (list (make-posn 2 3)
                                (make-posn 129 180)
                                (make-posn 145 123)
                                (make-posn 100 6)))
              (place-image (circle 10 "solid" "blue")
                           2 3
                           (place-image (circle 10 "solid" "blue")
                                        129 180
                                        (place-image (circle 10 "solid" "blue")
                                                     145 123
                                                     (place-image (circle 10 "solid" "blue")
                                                                  100 6
                                                                  (empty-scene 200 200))))))
; abstract-three : [[Listof X] -> Number or Image] [Listof X] -> Number or Image
; applies the given function to the given list
(define (abstract-three fn listof)
  (cond [(equal? fn draw-pairs)
         (cond [(empty? listof) (empty-scene 200 200)]
               [else (place-image (circle 10 "solid" "blue")
                                  (posn-x (first listof))
                                  (posn-y (first listof))
                                  (draw-pairs (rest listof)))])]
        [(or (equal? fn count-los) (equal? fn count-lon))
         (cond [(empty? listof) 0]
               [else (add1 (count-los (rest listof)))])]))