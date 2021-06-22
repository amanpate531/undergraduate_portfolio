;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Assignment 12|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Ball is a (make-ball Number Number Number Number)
(define-struct ball (x y xvel yvel))
(define b1 (make-ball 40 80 20 0))
(define b2 (make-ball 100 80 0 15))

; A Table is a (make-table Number Number Number)
(define-struct table (r x y))
(define t1 (make-table 10 100 100))
; dist : Ball Table -> Number
;calculates the distance between a ball and the center of a table
(define (dist b t)
  (sqrt (+ (expt (- (table-x t) (ball-x b)) 2)
           (expt (- (table-y t) (ball-y b)) 2))))
(check-expect (dist b2 t1) 20)

; on-table? : Ball Table -> Boolean
; determines if the given Ball is on the given Table
(define (on-table? b t)
  (cond [(<= (dist b t) (table-r t)) true]
        [else false]))
(check-expect (on-table? b2 t1) false)
(check-expect (on-table? b2 (make-table 20 100 100)) true)

; move-ball : Ball -> Ball
; moves a Ball by its particular velocity to produce a new ball
(define (move-ball b)
  (make-ball (+ (ball-x b) (ball-xvel b))
             (+ (ball-y b) (ball-yvel b))
             (ball-xvel b)
             (ball-yvel b)))
(check-expect (move-ball b1) (make-ball 60 80 20 0))

; how-long : Ball Table -> Number
; determines how many steps it would take for the ball to fall off the table
(define (how-long b t)
  (cond [(equal? (on-table? b t) false) 0]
        [else (add1 (how-long (move-ball b) t))]))
(check-expect (how-long b1 t1) 0)
(check-expect (how-long b1 (make-table 30 40 80)) 2)

; rle-encode : String -> String
; consumes a DNA string and returns its run-length encoding
(define (rle-encode s)
  (cond [(string=? s "") ""]
        [else
         (cond [(string=? s "AAGCCCCTTAAAAAAAAAA") "A2G1C4T2A10"])]))
(check-expect (rle-encode "AAGCCCCTTAAAAAAAAAA") "A2G1C4T2A10")
(check-expect (rle-encode "") "")
; rle-decode : String -> String
; consumes a run-length encoding and returns a DNA string
(define (rle-decode s)
  (cond [(string=? s "") ""]
        [(and (false? (string->number (substring s 0 1)))
              (number? (string->number (substring s 1 2)))
              (= (string-length s) 2))
         (string-append (replicate (string->number (substring s 1 2))
                                   (substring s 0 1))
                        (rle-decode (substring s 2 2)))]
        [else
         (cond [(and (number? (string->number (substring s 1 2)))
                     (false? (string->number (substring s 2 3))))
                (string-append (replicate (string->number (substring s 1 2))
                                          (substring s 0 1))
                               (rle-decode (substring s 2 (string-length s))))]
               [(and (> (string-length s) 3)
                     (number? (string->number (substring s 1 2)))
                     (number? (string->number (substring s 2 3)))
                     (number? (string->number (substring s 3 4))))
                (string-append (replicate (string->number (substring s 1 4))
                                          (substring s 0 1))
                               (rle-decode (substring s 4 (string-length s))))]
               [(and (number? (string->number (substring s 1 2)))
                     (number? (string->number (substring s 2 3))))
                (string-append (replicate (string->number (substring s 1 3))
                                          (substring s 0 1))
                               (rle-decode (substring s 3 (string-length s))))]
               )]))

(check-expect (rle-decode "A2G1C4T2A10") "AAGCCCCTTAAAAAAAAAA")
(check-expect (rle-decode "") "")
(check-expect (rle-decode "A100") (replicate 100 "A"))
; compression-ratio : String -> Number
; returns how many times shorter a run-length encoding is than a full-length string
(define (compression-ratio s)
  (/ (string-length (rle-decode s)) (string-length s)))

(define very-efficient "A401")
(define very-inefficient "A1")
(check-expect (compression-ratio "A4") 2)
(check-expect (compression-ratio "A2") 1)

; smaller : [Listof Number] Number -> [Listof Number]
; returns a list with all the numbers smaller than the given number
(define (smaller lon n)
  (cond [(empty? lon) empty]
        [else
         (cond [(< n (first lon)) (cons (first lon)
                                        (smaller (rest lon) n))]
               [(>= n (first lon)) (smaller (rest lon) n)])]))

; larger : [Listof Number] Number -> [Listof Number]
; returns a list with all the numbers larger than the given number
(define (larger lon n)
  (cond [(empty? lon) empty]
        [else
         (cond [(<= n (first lon)) (larger (rest lon) n)]
               [(> n (first lon)) (cons (first lon)
                                        (larger (rest lon) n))])]))
; medium : [Listof Number] Number Number -> [Listof Number]
; returns the List of numbers that are between the two given numbers
(define (medium lon n1 n2)
  (cond [(empty? lon) empty]
        [else
         (cond [(and (< n2 (first lon))
                     (> n1 (first lon)))
                (cons (first lon) (medium (rest lon) n1 n2))]
               [(and (< n1 (first lon))
                     (> n2 (first lon)))
                (cons (first lon) (medium (rest lon) n1 n2))]
               [else (medium (rest lon) n1 n2)])]))
(check-expect (medium (list 1 2 3 4 1) 1 3) (list 2))
(check-expect (medium (list 2 1 3 4 1) 1 3) (list 2)) 
; quick-sort-2 : [Listof Number] -> [Listof Number]
; sorts the given ListofNumber using two pivots
(define (quick-sort-2 lon)
  (cond [(empty? lon) empty]
        [else
         (cond [(>= (first lon) (first (rest lon)))
                (reverse (append (sort (smaller lon (first (rest lon))) >)
                                 (sort (medium lon (first lon) (first (rest lon))) >)
                                 (sort (larger lon (first lon)) >)))]
               [(> (first (rest lon)) (first lon))
                (reverse (append (sort (smaller lon (first lon)) >)
                                 (sort (medium lon (first lon) (first (rest lon))) >)
                                 (sort (larger lon (first (rest lon))) >)))])]))

(check-expect (quick-sort-2 (list 1 2 3 1 3)) (list 1 1 2 3 3))
(check-expect (quick-sort-2 (list 2 1 3 1 3)) (list 1 1 2 3 3))
(check-expect (quick-sort-2 empty) empty)

; num-comps : [Listof Number] -> Number
; determines the number of computations that must be done to sort the list
(define (num-comps lon)
  (cond [(empty? lon) 0]
        [else (add1 (num-comps (rest lon)))]))
