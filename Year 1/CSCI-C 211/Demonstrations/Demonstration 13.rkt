;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Demonstration 13|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; say-hi-to-everyone : [Listof String] -> [Listof String]
; add "hi" to each string in the list
(define (say-hi-to-everyone los)
  (map say-hi los))
(define (say-hi-to-everyone.v2 los)
  (foldr combine empty los))
(define (say-hi-to-everyone.v3 los)
  (map (lambda (name) (string-append "hi, " name)) los))
; combine : String [Listof String] -> [Listof String]
(define (combine x y)
  (cons (say-hi x) y))

(check-expect (say-hi-to-everyone empty) empty)
(check-expect (say-hi-to-everyone (list "alice" "bob")) (list "hi, alice" "hi, bob"))
(check-expect (say-hi-to-everyone.v2 empty) empty)
(check-expect (say-hi-to-everyone.v2 (list "alice" "bob")) (list "hi, alice" "hi, bob"))
; say-hi : String -> String
; appends "hi" to the given string
(define (say-hi s)
  (string-append "hi, " s))

; math : [Listof X] Base Op -> X
(define (math op base lst)
  (cond [(empty? lst) base]
        [else (op (first lst)
                  (math op base (rest lst)))]))

(require 2htdp/image)

; triangles : NaturalNumber -> Image
; draw the sierpinski triangle of depth n
(define (triangles n)
  (cond [(equal? 0 n) (triangle 20 "solid" "red")]
        [else (above (triangles (- n 1))
                     (beside (triangles (- n 1))
                             (triangles (- n 1))))]))

(check-expect (triangles 0) (triangle 20 "solid" "red"))
(check-expect (triangles 1) (above (triangle 20 "solid" "red")
                                   (beside (triangle 20 "solid" "red")
                                           (triangle 20 "solid" "red"))))
(define (buffalo! n)
  (cond [(equal? n 0) "buffalo"]
        [else (string-append "buffalo " (buffalo! (- n 1)))]))

; repeat : NaturalNumber [X -> X] X -> X
