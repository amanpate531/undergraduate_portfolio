;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Assignment 8|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Mobile is one of:
; - (make-leaf Number)
; - (make-rod Mobile Number Number Mobile)

(define-struct leaf (weight))
(define-struct rod (lm ld rd rm))

; enlarge : Mobile -> Mobile
; multiplies all distances in a mobile by two
(define (enlarge m)
  (cond [(leaf? m) m]
        [else (make-rod (enlarge (rod-lm m))
                        (* 2 (rod-ld m))
                        (* 2 (rod-rd m))
                        (enlarge (rod-rm m)))]))
(check-expect (enlarge (make-leaf 3)) (make-leaf 3))
(check-expect (enlarge (make-rod (make-leaf 4)
                                 20 20
                                 (make-leaf 45)))
              (make-rod (make-leaf 4) 40 40 (make-leaf 45)))

; lighten : Mobile -> Mobile
; halves the weights of all leaves in a mobile
(define (lighten m)
  (cond [(leaf? m) (make-leaf (/ (leaf-weight m) 2))]
        [else (make-rod (lighten (rod-lm m))
                        (rod-ld m)
                        (rod-rd m)
                        (lighten (rod-rm m)))]))
(check-expect (lighten (make-leaf 6)) (make-leaf 3))
(check-expect (lighten (make-rod (make-leaf 2)
                                 34 34
                                 (make-leaf 90)))
              (make-rod (make-leaf 1) 34 34 (make-leaf 45)))

; abstract-mobile : Mobile [Mobile -> Mobile] -> Mobile
; applies the given operation to the given mobile
(define (abstract-mobile m op)
  (cond [(equal? op enlarge)
         (cond [(leaf? m) m]
               [else (make-rod (enlarge (rod-lm m))
                               (* 2 (rod-ld m))
                               (* 2 (rod-rd m))
                               (enlarge (rod-rm m)))])]
        [(equal? op lighten)
         (cond [(leaf? m) (make-leaf (/ (leaf-weight m) 2))]
               [else (make-rod (lighten (rod-lm m))
                               (rod-ld m)
                               (rod-rd m)
                               (lighten (rod-rm m)))])]))
(check-expect (abstract-mobile (make-leaf 3) enlarge) (make-leaf 3))
(check-expect (abstract-mobile (make-rod (make-leaf 4)
                                         20 20
                                         (make-leaf 45)) enlarge)
              (make-rod (make-leaf 4) 40 40 (make-leaf 45)))
(check-expect (abstract-mobile (make-leaf 6) lighten) (make-leaf 3))
(check-expect (abstract-mobile (make-rod (make-leaf 2)
                                         34 34
                                         (make-leaf 90)) lighten)
              (make-rod (make-leaf 1) 34 34 (make-leaf 45)))

; A NEList-of-temperatures is one of:
; - (cons CTemperature empty)
; - (cons CTemperature NEList-of-temperatures)

; A NEList-of-Booleans is one of:
; - (cons Boolean empty)
; - (cons Boolean NEList-of-Booleans)

; A [NEList-of X] is one of:
; - (cons X empty)
; - (cons X [NEList-of X])

(require 2htdp/image)

(define s1 (cons "hello" empty))
(define s2 (cons "hello" (cons "hi" empty)))
(define p1 (cons (make-posn 3 4) empty))
(define p2 (cons (make-posn 3 4) (cons (make-posn 4 5) empty)))
(define i1 (cons (triangle 30 "solid" "red") empty))
(define i2 (cons (triangle 30 "solid" "red")
                 (cons (square 34 "solid" "green") empty)))

; min-string-length : ListofString -> Number
; returns the length of the shortest string in the given ListofString
(define (min-string-length los)
  (cond [(empty? los) 1000000000000000000000000000]
        [else (min (string-length (first los)) (min-string-length (rest los)))]))
(check-expect (min-string-length (list "asd" "asdf" "as")) 2)

; shortest-string : NEListofString -> String
; returns the shortest string in a nonempty ListofString
(define (shortest-string nelos)
  (cond [(= (string-length (first nelos)) (min-string-length nelos)) (first nelos)]
        [else (shortest-string (rest nelos))]))

(check-expect (shortest-string (list "asd" "asdf" "as")) "as")

; dist-min : ListofPosn -> Number
; determines the distance from the posn closest to the origin to the origin
(define (dist-min lop)
  (cond [(empty? lop) 10000000000000]
        [else (min (sqrt (+ (expt (posn-x (first lop)) 2)
                            (expt (posn-y (first lop)) 2)))
                   (dist-min (rest lop)))]))
(check-expect (dist-min (cons (make-posn 3 4) empty)) 5)

; closest-posn : NEListofPosn -> Posn
; returns the posn that is closest to the origin
(define (closest-posn nelop)
  (cond [(= (dist-min nelop) (sqrt (+ (expt (posn-x (first nelop)) 2)
                                      (expt (posn-y (first nelop)) 2))))
         (first nelop)]
        [else (closest-posn (rest nelop))]))
(check-expect (closest-posn (list (make-posn 4 3) (make-posn 4 6)))
              (make-posn 4 3))
(check-expect (closest-posn (list (make-posn 3 4) (make-posn 0 0)))
              (make-posn 0 0))

; count-loi : ListofImage -> Number
; returns the number of elements in the given ListofImage
(define (count-loi loi)
  (cond [(empty? loi) 0]
        [else (add1 (count-loi (rest loi)))]))

(check-expect (count-loi empty) 0)
(check-expect (count-loi (list (circle 20 "solid" "red")
                               (square 23 "outline" "green"))) 2)

; min-loloi : ListofListofImage -> Number
; returns the length of the shortest list
(define (min-loloi loloi)
  (cond [(empty? loloi) 10000000000000]
        [else (min (count-loi (first loloi))
                   (count-loi (rest loloi)))]))

(check-expect (min-loloi (list (list (circle 10 "solid" "red")
                                       (square 10 "solid" "blue"))
                                 (list (circle 20 "solid" "green"))))
              1)
; shortest-list : NEListofListofImage -> ListofImage
; returns the ListofImage with the fewest elements in the given ListofListofImage
(define (shortest-list neloloi)
  (cond [(= (count-loi (first neloloi)) (min-loloi neloloi))
         (first neloloi)]
        [else (shortest-list (rest neloloi))]))

; abstract-list : [NEListof X] Op -> X
; applies the given operation to the given NEList
(define (abstract-list NEL op)
  (cond [(equal? op shortest-string)
         (cond [(= (string-length (first NEL)) (min-string-length NEL)) (first NEL)]
               [else (shortest-string (rest NEL))])]
        [(equal? op closest-posn)
         (cond [(= (dist-min NEL) (sqrt (+ (expt (posn-x (first NEL)) 2)
                                             (expt (posn-y (first NEL)) 2))))
                (first NEL)]
               [else (closest-posn (rest NEL))])]
        [(equal? op shortest-list)
         (cond [(= (count-loi (first NEL)) (min-loloi NEL))
                (first NEL)]
               [else (shortest-list (rest NEL))])]))

(check-expect (abstract-list (list (make-posn 3 4)
                                   (make-posn 0 0))
                             closest-posn)
              (make-posn 0 0))
(check-expect (abstract-list (list (make-posn 0 0)
                                   (make-posn 3 4))
                             closest-posn)
              (make-posn 0 0))
(check-expect (abstract-list (list "a" "as" "asdf")
                             shortest-string)
              "a")
(check-expect (abstract-list (list "as" "as" "a")
                             shortest-string)
              "a")

; remove-even : ListofNumber -> ListofNumber
; removes all even elements of a ListofNumber
(define (remove-even lon)
  (cond [(empty? lon) empty]
        [else
         (cond [(even? (first lon)) (remove-even (rest lon))]
               [else (cons (first lon) (remove-even (rest lon)))])]))
(check-expect (remove-even (list 2 3 4)) (list 3))
(check-expect (remove-even empty) empty)

; remove-empty : ListofListofNumber -> ListofListofNumber
; removes all empty lists from a given ListofListofNumber
(define (remove-empty lolon)
  (cond [(empty? lolon) empty]
        [else
         (cond
           [(empty? (first lolon)) (remove-empty (rest lolon))]
           [else (cons (first lolon) (remove-empty (rest lolon)))])]))
(check-expect (remove-empty empty) empty)
(check-expect (remove-empty (list (list 2 3 4)
                                  empty
                                  (list 1 2 3)))
              (list (list 2 3 4)
                    (list 1 2 3)))
(check-expect (remove-empty (list empty
                                  (list 2 3 4)
                                  (list 1 2 3)))
              (list (list 2 3 4)
                    (list 1 2 3)))

; tab-sin : Number -> [Listof Number]
; tabulates sin between n and 0 (incl.) in a list
(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else (cons (sin n) (tab-sin (sub1 n)))]))
(check-within (tab-sin 1)
              (list (sin 1) 0) 0.01)

; tab-sqrt : Number -> [Listof Number]
; tabulates sqrt between n and 0 (incl.) in a list
(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else (cons (sqrt n) (tab-sqrt (sub1 n)))]))
(check-expect (tab-sqrt 1)
              (list 1 0))

; tabulate : Number Op -> [Listof Number]
; tabulates the given operation between n and 0 (incl.) in a list
(define (tabulate n op)
  (cond
    [(= n 0) (list (op 0))]
    [else (cons (op n) (tabulate (sub1 n) op))]))

(check-within (tabulate 1 sin)
              (list (sin 1) 0) 0.01)
(check-expect (tabulate 1 sqrt)
              (list 1 0))

; tab-sqr : Number -> [Listof Number]
; tabulates sqr between n and 0 (incl.) in a list
(define (tab-sqr n)
  (tabulate n sqr))
(check-expect (tab-sqr 2)
              (list 4 1 0))

; tab-tan : Number -> [Listof Number]
; tabulates tan between n and 0 (incl.) in a list
(define (tab-tan n)
  (tabulate n tan))
(check-expect (tab-tan 0) (list 0))

; has-< : [List of Number] Number -> Boolean
; determines if an element of the ListofNumber is less than a given number
(define (has-< lon n)
  (cond [(empty? lon) false]
        [else
         (cond [(> n (first lon)) true]
               [else (has-< (rest lon) n)])]))
(check-expect (has-< (list 10 11 350 1) 4) true)
(check-expect (has-< empty 3) false)

; has-string=? : [Listof String] String -> Boolean
; determines if the given string is an element in the ListofString
(define (has-string=? los s)
  (cond [(empty? los) false]
        [else
         (cond [(string=? s (first los)) true]
               [else (has-string=? (rest los) s)])]))
(check-expect (has-string=? (list "as" "sdf" "4wr") "sdf") true)
(check-expect (has-string=? empty "s") false)

; has-empty? : [Listof [Listof Image]] -> Boolean
; determines if the given ListofListofImage contains empty
(define (has-empty? loloi)
  (cond [(empty? loloi) false]
        [else
         (cond [(empty? (first loloi)) true]
               [else (has-empty? (rest loloi))])]))
(check-expect (has-empty? empty) false)
(check-expect (has-empty? (list (list (circle 10 "solid" "red"))
                                empty))
              true)

; abstract-has : [Listof X] X Op -> Boolean
; applies the operation to the given [Listof X]
(define (abstract-has lox x op)
  (cond [(equal? op has-<)
         (cond [(empty? lox) false]
               [else
                (cond [(> x (first lox)) true]
                      [else (has-< (rest lox) x)])])]
        [(equal? op has-string=?)
         (cond [(empty? lox) false]
               [else
                (cond [(string=? x (first lox)) true]
                      [else (has-string=? (rest lox) x)])])]
        [(equal? op has-empty?)
         (cond [(empty? lox) false]
               [else
                (cond [(empty? (first lox)) true]
                      [else (has-empty? (rest lox))])])]))
(check-expect (abstract-has (list 10 11 350 1) 4 has-<) true)
(check-expect (abstract-has empty 3 has-<) false)
(check-expect (abstract-has (list "as" "sdf" "4wr") "sdf" has-string=?) true)
(check-expect (abstract-has empty "s" has-string=?) false)
(check-expect (abstract-has empty "s" has-empty?) false)
(check-expect (abstract-has (list (list (circle 10 "solid" "red")) empty) "s" has-empty?) true)

; mult-n : Number Number -> Number
; multiplies the two given numbers together
(define (mult-n x n)
  (* x n))
; mult-lon : ListofNumber Number -> ListofNumber
; multiplies all elements of a ListofNumber by the given number
;(define (mult-lon lon n)
;  (map (lambda (n) (* n)) lon))
;(check-expect (mult-lon (list 1 2 3) 4)
;              (list 4 8 12))

(define-struct leaf2 (n))
(define-struct node1 (n ton))
(define-struct node2 (n ton1 ton2))  
; A TreeofNumber is one of:
; - (make-leaf2 Number)
; - (make-node1 Number TreeofNumber)
; - (make-node2 Number TreeofNumber TreeofNumber)

; sum-tree : TreeofNumber -> Number
; sums all the numbers in a TreeofNumber
(define (sum-tree ton)
  (cond [(leaf2? ton) (leaf2-n ton)]
        [(node1? ton) (+ (node1-n ton)
                         (sum-tree (node1-ton ton)))]
        [(node2? ton) (+ (node2-n ton)
                         (sum-tree (node2-ton1 ton))
                         (sum-tree (node2-ton2 ton)))]))
(check-expect (sum-tree (make-leaf2 3)) 3)
(check-expect (sum-tree (make-node1 3 (make-leaf2 34))) 37)
(check-expect (sum-tree (make-node2 3 (make-leaf2 3) (make-leaf2 4))) 10)

; prod-tree : TreeofNumber -> Number
; multiplies all the numbers in a TreeofNumber
(define (prod-tree ton)
  (cond [(leaf2? ton) (leaf2-n ton)]
        [(node1? ton) (* (node1-n ton)
                         (prod-tree (node1-ton ton)))]
        [(node2? ton) (* (node2-n ton)
                         (prod-tree (node2-ton1 ton))
                         (prod-tree (node2-ton2 ton)))]))
(check-expect (prod-tree (make-leaf2 2)) 2)
(check-expect (prod-tree (make-node1 3 (make-leaf2 4))) 12)
(check-expect (prod-tree (make-node2 3 (make-leaf2 4) (make-leaf2 5))) 60)

; op-tree : TreeofNumber Op -> Number
; applies the given operation to the TreeofNumber
(define (op-tree ton op)
  (cond [(equal? op sum-tree)
         (cond [(leaf2? ton) (leaf2-n ton)]
               [(node1? ton) (+ (node1-n ton)
                                (sum-tree (node1-ton ton)))]
               [(node2? ton) (+ (node2-n ton)
                                (sum-tree (node2-ton1 ton))
                                (sum-tree (node2-ton2 ton)))])]
        [(equal? op prod-tree)
         (cond [(leaf2? ton) (leaf2-n ton)]
               [(node1? ton) (* (node1-n ton)
                                (prod-tree (node1-ton ton)))]
               [(node2? ton) (* (node2-n ton)
                                (prod-tree (node2-ton1 ton))
                                (prod-tree (node2-ton2 ton)))])]))
        
(check-expect (op-tree (make-leaf2 3) sum-tree) 3)
(check-expect (op-tree (make-node1 20 (make-leaf2 3)) prod-tree) 60)
(check-expect (op-tree (make-node2 2 (make-leaf2 3) (make-leaf2 3)) prod-tree)
              18)

; count-tree : TreeofNumber -> Number
; counts how many leaves are in the given TreeofNumber
(define (count-tree ton)
  (cond [(leaf2? ton) 1]
        [(node1? ton) (count-tree (node1-ton ton))]
        [(node2? ton) (+ (count-tree (node2-ton1 ton))
                         (count-tree (node2-ton2 ton)))]))

(check-expect (count-tree (make-leaf2 21)) 1)
(check-expect (count-tree (make-node1 3 (make-leaf2 20))) 1)
(check-expect (count-tree (make-node2 2 (make-leaf2 29) (make-leaf2 2)))
              2)

; process-tree : TreeofNumber [TreeofNumber -> Number] -> Number
; applies the given operation to the TreeofNumber
; same with an extra clause in the conditional for count-tree
(define (process-tree ton op)
  (cond [(equal? op sum-tree)
         (cond [(leaf2? ton) (leaf2-n ton)]
               [(node1? ton) (+ (node1-n ton)
                                (sum-tree (node1-ton ton)))]
               [(node2? ton) (+ (node2-n ton)
                                (sum-tree (node2-ton1 ton))
                                (sum-tree (node2-ton2 ton)))])]
        [(equal? op prod-tree)
         (cond [(leaf2? ton) (leaf2-n ton)]
               [(node1? ton) (* (node1-n ton)
                                (prod-tree (node1-ton ton)))]
               [(node2? ton) (* (node2-n ton)
                                (prod-tree (node2-ton1 ton))
                                (prod-tree (node2-ton2 ton)))])]
        [(equal? op count-tree)
         (cond [(leaf2? ton) 1]
               [(node1? ton) (count-tree (node1-ton ton))]
               [(node2? ton) (+ (count-tree (node2-ton1 ton))
                                (count-tree (node2-ton2 ton)))])]))

(check-expect (process-tree (make-leaf2 21) count-tree) 1)
(check-expect (process-tree (make-node1 3 (make-leaf2 20)) count-tree) 1)
(check-expect (process-tree (make-node2 2 (make-leaf2 29)
                                        (make-leaf2 2)) count-tree) 2)
(check-expect (process-tree (make-leaf2 2) prod-tree) 2)
(check-expect (process-tree (make-node1 3 (make-leaf2 4)) prod-tree) 12)
(check-expect (process-tree (make-node2 3 (make-leaf2 4)
                                        (make-leaf2 5)) prod-tree) 60)
(check-expect (process-tree (make-leaf2 3) sum-tree) 3)
(check-expect (process-tree (make-node1 3 (make-leaf2 34)) sum-tree) 37)
(check-expect (process-tree (make-node2 3 (make-leaf2 3)
                                        (make-leaf2 4)) sum-tree) 10)

; A [Treeof X] is one of:
; - (make-leaf X)
; - (make-node1 X [Treeof X])
; - (make-node2 X [Treeof X] [Treeof X])

; General process-tree
; Yes

; General count-tree
; Yes