;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lab 9|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; farthest : Posn ListofPosn -> Posn
; finds the posn in the ListofPosn that is farthest from the given posn
(define (farthest p lop)
  (local [; dist-posn : Posn Posn -> Posn
          ; compares two given posns to see which is farther from the original posn
          (define (dist-posn p1 p2)
            (cond [(> (sqrt (+ (expt (- (posn-x p) (posn-x p2)) 2) (expt (- (posn-y p) (posn-y p2)) 2)))
                      (sqrt (+ (expt (- (posn-x p1) (posn-x p)) 2) (expt (- (posn-y p1) (posn-y p)) 2))))
                   p2]
                  [else p1]))]
    (foldl dist-posn (first lop) lop)))

(check-expect (farthest (make-posn 3 4) (list (make-posn 100 100)
                                              (make-posn 0 0)
                                              (make-posn 3 5)))
              (make-posn 100 100))

; count : ListofNumber -> Number
; returns the number of elements in the given ListofNumber
(define (count lon)
  (local [; helper-lon : Number Number -> Number
          ; adds one to the total count
          (define (helper-n n n1)
            (add1 n1))]
          (foldl helper-n 0 lon)))

(check-expect (count (list 1 2 3 4)) 4)
(check-expect (count (list 1 4)) 2)
(check-expect (count (list 1 2 3 4 5 6 7 8 9 0)) 10)

; random-hello : ListofString Number -> ListofString
; randomly appends "Hello, " to some of the strings in a ListofString
;(define (random-hello los x)
;  (cond [(> (random (length los)) x) (string-append ]
;        [(random (length los))]))
; sometimes-hello: ListofString -> ListofString
; randomly says hello to some of the names in the given ListofString
;(define (sometimes-hello los)
;  (map ... los))

;(check-random (sometimes-hello (list "Daniel" "Alicia" "Bao" "Amina" "Hiroki"))
;              (list "Daniel" "Hello, Alicia" "Bao" "Hello, Amina" "Hiroki"))

(build-list 10 (lambda(x) x))
; (list 0 1 2 3 4 5 6 7 8 9)
(build-list 10 (lambda(x) (+ 1 x)))
; (list 1 2 3 4 5 6 7 8 9 10)
(build-list 10 (lambda (x) 1))
; (list 1 1 1 1 1 1 1 1 1 1)
(build-list 5 (lambda(x) (/ x 10)))
; (list 0 0.1 0.2 0.3 0.4)
(build-list 10 (lambda(x) (expt 3 x)))
; (list 1 3 9 27 81 243 729 2187 6561 19683)

; evens-first : Number -> ListofNumber
; builds a list with the first n even numbers
(define (evens-first n)
  (build-list n (lambda(x) (* 2 x))))

(check-expect (evens-first 4) (list 0 2 4 6))

; evens*-first : Number -> ListofNumber
; builds a list with the first n even numbers starting at 2
(define (evens*-first n)
  (build-list n (lambda(x) (* 2 (add1 x)))))

(check-expect (evens*-first 2) (list 2 4))

; odds-first : Number -> ListofNumber
; builds a list with the first n odd numbers
(define (odds-first n)
  (build-list n (lambda(x) (add1 (* 2 x)))))

(check-expect (odds-first 3) (list 1 3 5))

; powers-of-ten : Number -> ListofNumber
; builds a list with the powers of ten in descending order starting at 1
(define (powers-of-ten n)
  (build-list n (lambda(x) (expt 10 (* x -1)))))

(check-expect (powers-of-ten 2) (list 1 0.1))

(build-list 10 (lambda(x) (if (= x 3) 1 0)))
; (list 0 0 0 1 0 0 0 0 0 0)
(build-list 10 (lambda(x) (if (= x 4) 1 0)))
; (list 0 0 0 0 1 0 0 0 0 0)
(build-list 10 (lambda(x) (if (= x 5) 1 0)))
; (list 0 0 0 0 0 1 0 0 0 0)

; diagonal : Number -> ListofListofNumber
; creates n lists of 0 and 1 in a diagonal arrangement within a single list


(build-list 10 (lambda(x) (random 10)))
; (list (random 10) (random 10) (random 10) (random 10) (random 10)
; (random 10) (random 10) (random 10) (random 10) (random 10))

(build-list 10 (lambda(x) (random (add1 x))))
; (list 0 (random 2) (random 3) (random 4) (random 5)
; (random 6) (random 7) (random 8) (random 9) (random 10) (random 11)

; random-between : Number Number Number -> [Listof Number]
; generates list of how-many numbers randomly chosen between low and high
(define (random-between low high how-many)
  (build-list how-many (lambda(x) (if (> (abs low) (abs high))
                                      (random (abs low)) (random (abs high))))))

(random-between -23 20 3)
