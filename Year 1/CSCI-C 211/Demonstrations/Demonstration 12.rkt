;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Demonstration 12|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; move-down : Posn -> Posn
; move the posn's y coord down
(define (move-down p)
  (make-posn (posn-x p) (- (posn-y p) 10)))

; move-all-down : [Listof Posn] -> [Listof Posn]
; move all the posns down
(define (move-all-down lop)
  (cond [(empty? lop) lop]
        [else (cons (move-down (first lop))
                    (move-all-down (rest lop)))]))

(define (move-all-down.v2 lop)
  (map move-down lop))

(check-expect (move-all-down (list (make-posn 10 10)))
              (list (make-posn 10 0)))
(check-expect (move-all-down.v2 (list (make-posn 10 10)))
              (list (make-posn 10 0)))

; map : [X -> Y] [Listof X] -> [Listof Y]

; add-n-to-all : [Listof Number] Number -> [Listof Number]
; adds n to every element in the given list
(define (add-n-to-all lon n)
  (local [; addn : Number -> Number
          ; adds n to the given number
          (define (addn x) (+ n x))]
  (map addn lon)))

(check-expect (add-n-to-all empty 3) empty)
(check-expect (add-n-to-all (list 1 2 3) 7) (list 8 9 10))