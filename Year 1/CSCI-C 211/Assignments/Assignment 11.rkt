;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Assignment 11|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A PrefixForest is a [NEListof PrefixTree]

; A PrefixTree is a:
; - (make-end)
; - (make-node 1String PrefixForest)

(define-struct end ())
(define-struct node (letter forest))

(define pt1
  (make-node "o"
           (list (make-node "n" (list
                                 (make-end)
                                 (make-node "e" (list (make-end)))))
                 (make-node "f" (list
                                 (make-end)
                                 (make-node "f" (list (make-end)))
                                 (make-node "t" (list (make-end)))))
                 (make-node "r" (list (make-end))))))

; a Word is a [Listof 1String]
; pt2 : fog, for, fit, fill, fin, fan
(define pt2 (make-node "f"
                       (list (make-node "o" (list
                                             (make-node "g" (list (make-end)))
                                             (make-node "r" (list (make-end)))))
                             (make-node "i" (list
                                             (make-node "t" (list (make-end)))
                                             (make-node "l" (list
                                                             (make-node "l" (make-end))))
                                             (make-node "n" (list (make-end)))))
                             (make-node "a" (list
                                             (make-node "n" (list (make-end))))))))


(define pf1 (list (make-node "a" (list
                                  (make-end)
                                  (make-node "t" (list (make-end)))))
                  (make-node "d" (list
                                  (make-node "o" (list (make-end)))
                                  (make-node "a" (list (make-node "b" (list (make-end)))))))))

(define pf2 (list (make-node "p" (list
                                  (make-node "a" (list
                                                  (make-end)
                                                  (make-node "t" (list (make-end)))
                                                  (make-node "l" (list (make-end)))))
                                  (make-node "o" (list
                                                  (make-node "t" (list (make-end)))
                                                  (make-node "p" (list (make-end)))
                                                  (make-node "w" (list (make-end)))))))
                  (make-node "l" (list
                                  (make-node "a" (list
                                                  (make-end)
                                                  (make-node "p" (list (make-end)))
                                                  (make-node "b" (list (make-end)))))
                                  (make-node "e" (list
                                                  (make-node "t" (list (make-end)))
                                                  (make-node "e" (list (make-end)))))))))

; letternode : PrefixForest -> ListofString
; creates a ListofString with the letters in a given PrefixForest
;(define (letternode pf)
;  (cond [(empty? pf) empty]
;        [else
;         (cond [(end? (first pf)) (cons (first pf) (letternode (rest pf)))]
;               [(node? (first pf)) (cons (letternode (rest pf))
;                                         (cons (first pf) empty))])]))

; alphabetize : PrefixForest -> PrefixForest
; reorders the nodes so that the ends are first and nodes are in alphabetical order
(define (alphabetize pf)
  (cond [(empty? pf) empty]
        [else
         (cond [(end? (first pf)) (cons (first pf) (alphabetize (rest pf)))]
               [else (alphabetize (append (rest pf) (list (first pf))))])]))

; word-in-tree? : Word PrefixTree -> Boolean
; determines if the given word is in the given PrefixTree
(define (word-in-tree? w pt)
  (cond [(empty? (explode w)) true]
        [else
         (cond [(string=? (first (explode w)) (node-letter pt)) (word-in-forest? w (node-forest pt))]
               [else false])]))
                
; any-true? : [Listof Boolean] -> Boolean
; returns true if any of the booleans in the given list are true
(define (any-true? lob)
  (cond [(empty? lob) false]
        [else
         (cond [(= (first lob) true) true]
               [else (any-true? (rest lob))])]))

; word-in-forest? : Word PrefixForest -> [Listof Boolean]
; determines if the given word is in the given PrefixForest
(define (word-in-forest? w pf)
  (cond [(empty? pf) false]
        [else (cons (word-in-tree? w (first pf)) (word-in-forest? w (rest pf)))]))

; remake : ListofString -> Word
; reappends the Word after first letter is extracted
(define (remake los)
  (cond [(empty? los) ""]
        [else (string-append (first los) (remake (rest los)))]))

; word->tree : Word -> PrefixTree
; creates a PrefixTree containing only the given word
(define (word->tree w)
  (cond [(empty? w) (make-end)]
        [else (make-node (first w) (list (word->tree (implode (rest w)))))]))

; add-to-tree : Word PrefixTree -> PrefixTree
; adds the given word to the PrefixTree
;(define (add-to-tree w pt)
;  (cond [(= (first (rest (explode w))) (first (pt-los pt)))
;         (make-node (first (explode w)) (cons (word->tree (first (rest (rest (explode w)))))
;                                              (node-forest pt)))]))

; pt-string : PrefixTree -> String
; combines the first letters in a PrefixTree to create a string
(define (node-string pt)
  (cond [(empty? (node-forest pt)) empty]
        [else
         (cond [(end? (first (node-forest pt))) (node-letter pt)]
               [else (list (string-append (node-letter pt)
                                          (node-string (first (node-forest pt))))
                           (string-append (node-letter pt)
                                          (node-string (first (rest (node-forest pt))))))])]))

; take : [Listof X] NaturalNumber -> [Listof X]
; keeps the first n items from l if possible or everything
(define (take l n)
  (cond [(zero? n) empty]
        [(empty? l) empty]
        [else (cons (first l) (take (rest l) (sub1 n)))]))

; drop : [Listof X] NaturalNumber -> [Listof X]
; removes the first n items from l if possible or everything
(define (drop l n)
  (cond [(zero? n) l]
        [(empty? l) l]
        [else (drop (rest l) (sub1 n))]))
; list->chunks : [Listof X] NaturalNumber -> [Listof [Listof X]]
; creates a list with chunks of length n of the original list
(define (list->chunks lox n)
  (cond [(empty? lox) empty]
        [else (cons (take lox n) (list->chunks (drop lox n) n))]))
(define (bundle l n)
  (cond [(empty? l) empty]
        [else (cons (implode (take l n)) (list->chunks (drop l n) n))]))

; partition : String Number -> [Listof String]
; produces a ListofString containing chunks of the given string with length n
(define (partition s n)
  (cond [(string=? s "") (list empty)]
        [(< (string-length s) n) s]
        [else (cons (implode (take (explode s) n))
                    (partition (implode (drop (explode s) n)) n))]))

; tokenize: [Listof 1String] -> [ListofString]
; creates a ListofString containing all adjacent lower-case letters
(define (tokenize lo1s)
  (cond [(empty? lo1s) empty]
        [else
         (cond [(and (string-lower-case? (first lo1s)) (string-lower-case? (second lo1s)))
                (cons (string-append (first lo1s) (second lo1s))
                      (tokenize (drop lo1s 2)))]
               [(string-lower-case? (first lo1s)) (cons (first lo1s)
                                                        (tokenize (drop lo1s 2)))]
               [(string-lower-case? (second lo1s)) (cons (second lo1s)
                                                        (tokenize (drop lo1s 2)))]
               [else (tokenize (drop lo1s 2))])]))

(check-expect (tokenize (list " " "-" " " ";" "d" "e"))
              (list "de"))
(check-expect (tokenize (list " " "-" " " ";" "d" "e" "(" ")"))
              (list "de"))
(check-expect (tokenize (list " " "-" " " ";" "#" "+"))
              (list))