;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Assignment 7|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; a frequency is a (make-freq String Number)
; contains a string and the amount of repetitions of that string
(define-struct freq (s n))

; a ListofString is one of:
; - empty
; - (cons String ListofString)

; a ListofFrequency is one of:
; - empty
; - (cons (make-freq String Number) ListofFrequency)

; process-lof : ListofFrequency -> ListofString
; extracts the strings from a listoffrequency
(define (process-lof lof)
  (cond [(empty? lof) empty]
        [else (cons (freq-s (first lof)) (process-lof (rest lof)))]))

(check-expect (process-lof (cons (make-freq "s" 2) empty))
              (cons "s" empty))
(check-expect (process-lof empty) empty)

; has-word? : ListofString String -> Boolean
; determines if a listofstring contains the given string
(define (has-word? los s)
  (cond [(empty? los) false]
        [else
         (cond [(string=? (first los) s) true]
               [else (has-word? (rest los) s)])]))

(check-expect (has-word? (list "a" "d" "g") "g") true)
(check-expect (has-word? (list "a" "d" "g") "w") false)

; count-word : ListofFrequency String -> ListofFrequency
; adds 1 to the frequency of the given string
(define (count-word lof s)
  (cond [(empty? lof) empty]
        [else
         (cond [(string=? s (freq-s (first lof))) (cons (make-freq
                                                         s
                                                         (+ 1 (freq-n (first lof))))
                                                        (count-word (rest lof) s))]
               [else
                (cond [(has-word? (process-lof lof) s)
                       (cons (first lof) (count-word (rest lof) s))]
                      [else (cons (make-freq s 1)
                                  (cons (first lof)
                                        (count-word (rest lof) s)))])])]))

(check-expect (count-word (cons (make-freq "a" 2) empty) "s")
              (list (make-freq "s" 1) (make-freq "a" 2)))
(check-expect (count-word (cons (make-freq "a" 2) empty) "a")
              (cons (make-freq "a" 3) empty))
(check-expect (count-word (list (make-freq "d" 2) (make-freq "s" 2)) "s")
              (list (make-freq "d" 2) (make-freq "s" 3)))

(require 2htdp/batch-io)
; count-all-words : ListofString -> ListofFrequency
; creates a listoffrequency based on the frequency of each string in a listofstring
(define (count-all-words los)
  (cond [(empty? los) empty]
        [else (count-word (cons (make-freq (first los) 0) 
                           (count-all-words (rest los))) (first los))]))

(check-expect (count-all-words (list "a" "a"))
              (list (make-freq "a" 1) (make-freq "a" 2)))
(check-expect (count-all-words empty)
              empty)
; frequents : ListofFrequency -> ListofFrequency
; creates a new listoffrequency with words over 100 appearances
(define (frequents lof)
  (cond [(empty? lof) empty]
        [else
         (cond [(> (freq-n (first lof)) 100) (cons (first lof) (frequents (rest lof)))]
               [else (frequents (rest lof))])]))

(check-expect (frequents (cons (make-freq "a" 103)
                               (cons (make-freq "d" 34) empty)))
              (cons (make-freq "a" 103) empty))
(check-expect (frequents empty) empty)
; A Mobile is one of:
; - (make-leaf Number)
; - (make-rod Mobile Number Number Mobile)
(define-struct leaf (weight))
(define-struct rod (lm ld rd rm))

; weight : Mobile -> Number
; calculates the total weight of a mobile
(define (weight m)
  (cond [(leaf? m) (leaf-weight m)]
        [(rod? m) (+ (weight (rod-lm m)) (weight (rod-rm m)))]))

; count-leaves : Mobile -> Number
; counts how many leaves are in the given mobile
(define (count-leaves m)
  (cond [(leaf? m) 1]
        [(rod? m) (+ (count-leaves (rod-lm m)) (count-leaves (rod-rm m)))]))

; average-leaf-weight : Mobile -> Number
; calculates the average weight of the leaves of the given mobile
(define (average-leaf-weight m)
  (/ (weight m) (count-leaves m)))

(check-expect (average-leaf-weight (make-rod (make-leaf 5)
                                             6
                                             32
                                             (make-leaf 7))) 6)

; balanced? : Mobile -> Boolean
; determines whether the given mobile is balanced at the top
(define (balanced? m)
  (cond [(leaf? m) true]
        [(rod? m) (= (* (rod-ld m) (weight (rod-lm m)))
                     (* (rod-rd m) (weight (rod-rm m))))]))

(check-expect (balanced? (make-leaf 4)) true)
(check-expect (balanced? (make-rod (make-leaf 5) 4 5 (make-leaf 6))) false)

; all-balanced: Mobile -> Boolean
; determines whether the given mobile is balanced everywhere
(define (all-balanced? m)
  (cond [(leaf? m) true]
        [(rod? m)
         (cond [(= (* (rod-ld m) (weight (rod-lm m)))
                     (* (rod-rd m) (weight (rod-rm m)))) true]
               [else false])]))

(check-expect (all-balanced? (make-leaf 4)) true)
(check-expect (all-balanced? (make-rod (make-leaf 4) 3 4 (make-leaf 3))) true)
(check-expect (all-balanced? (make-rod (make-leaf 5) 4 3 (make-leaf 7))) false)

; lighten : Mobile -> Mobile
; halves the weight of everything
(define (lighten m)
  (cond [(leaf? m) (make-leaf (/ (leaf-weight m) 2))]
        [(rod? m) (make-rod (lighten (rod-lm m))
                            (rod-ld m)
                            (rod-rd m)
                            (lighten (rod-rm m)))]))

(check-expect (lighten (make-leaf 6)) (make-leaf 3))
(check-expect (lighten (make-rod (make-leaf 6) 4 5 (make-leaf 4)))
              (make-rod (make-leaf 3) 4 5 (make-leaf 2)))

; enlarge : Number Mobile -> Mobile
; multiplies all distances in given mobile by given distance
(define (enlarge n m)
  (cond [(leaf? m) m]
        [(rod? m) (make-rod (rod-lm m)
                            (* n (rod-ld m))
                            (* n (rod-rd m))
                            (rod-rm m))]))

(check-expect (enlarge 3 (make-leaf 4)) (make-leaf 4))
(check-expect (enlarge 5 (make-rod (make-leaf 4) 4 5 (make-leaf 5)))
              (make-rod (make-leaf 4) 20 25 (make-leaf 5)))

; all-balanced-mobile : Number -> Mobile
; produces a mobile with the specified number of leaves that satisfies all-balanced?
(define (all-balanced-mobile n)
  (cond [(equal? n 1) (make-leaf 10)]
        [(<= n 0) "error"]
        [else (counterbalance (all-balanced-mobile (- n 1)))]))

(check-expect (all-balanced-mobile 3)
(make-rod
 (make-rod (make-leaf 10) 10 10 (make-leaf 10))
 10
 10
 (make-leaf 20)))
(check-expect (all-balanced-mobile 1) (make-leaf 10))
(check-expect (all-balanced-mobile 0) "error")

; counterbalance : Mobile -> Mobile
; adds a leaf to a given mobile in a balanced? way
(define (counterbalance m)
        (make-rod m 10 10 (make-leaf (weight m))))

(check-expect (counterbalance (make-leaf 10))
              (make-rod (make-leaf 10) 10 10 (make-leaf 10)))