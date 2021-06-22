;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Demonstration 7|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A NestingDoll is one of:
; - (make-hollow-doll NestingDoll)
; - (make-solid-doll Wood)
(define-struct hollow-doll (inner))
(define-struct solid-doll (wood))

; A Wood is a String
(define doll1
  (make-hollow-doll
   (make-hollow-doll
    (make-hollow-doll
     (make-solid-doll "spruce")))))
#;
(define (process-nesting-doll nd)
  (cond
    [(hollow-doll? nd) ...
     (process-nesting-doll (hollow-doll-inner nd))]
    [(solid-doll? nd) ... (solid-doll-wood nd)]))

; count-doll : NestingDoll -> Number
; count how many levels of doll there are

(define (count-doll nd)
  (cond [(hollow-doll? nd)
         (add1 (count-doll (hollow-doll-inner nd)))]
        [(solid-doll? nd) 1]))
(check-expect (count-doll doll1) 4)
(check-expect (count-doll (make-solid-doll "oak")) 1)


; change-wood : NestingDoll Wood -> NestingDoll
; produces a new doll with the specified wood of the same size
(define (change-wood nd w)
  (cond
    [(hollow-doll? nd) (make-hollow-doll
     (change-wood (hollow-doll-inner nd) w))]
    [(solid-doll? nd)
     (make-solid-doll w)]))
(check-expect (change-wood (make-solid-doll "oak") "spruce") (make-solid-doll "spruce"))
(check-expect (change-wood doll1 "pine")
              (make-hollow-doll
               (make-hollow-doll
                (make-hollow-doll
                 (make-solid-doll "pine")))))