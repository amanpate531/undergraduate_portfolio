;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Assignment 10|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct leaf (weight))
(define-struct rod (lm ld rd rm))
; weight : Mobile -> Number
; calculates the total weight of the mobile
(define (weight m)
  (cond [(leaf? m) (leaf-weight m)]
        [(rod? m) (+ (weight (rod-lm m))
                     (weight (rod-rm m)))]))
(check-expect (weight (make-leaf 20)) 20)
(check-expect (weight (make-rod (make-leaf 20)
                                20 20
                                (make-leaf 30))) 50)
; heavy-leaves : [Listof Mobile] Number -> Number
; counts how many leaves in the given ListofMobile are heavier than the given number
(define (heavy-leaves lom n)
  (cond [(empty? lom) 0]
        [else
         (cond [(> (weight (first lom)) n) (add1 (heavy-leaves (rest lom) n))]
               [else (heavy-leaves (rest lom) n)])]))
(check-expect (heavy-leaves empty 10) 0)
(check-expect (heavy-leaves (list (make-leaf 10)) 2) 1)
(check-expect (heavy-leaves (list (make-leaf 10)) 12) 0)

; Exercise 323
(define-struct no-info ())
(define NONE (make-no-info))
(define-struct node (ssn name left right))
; A BT is one of:
; - NONE
; - (make-node Number Symbol BT BT)

; search-bt : Number BinaryTree -> [Symbol, Boolean]
; returns the name of a node structure whose ssn field is n, false if ssn is not n
(define (search-bt n bt)
  (cond [(no-info? bt) #false]
        [else
         (cond [(= n (node-ssn bt)) (node-name bt)]
               [else #false])]))
(check-expect (search-bt 45 (make-node 45 'd NONE NONE)) 'd)
(check-expect (search-bt 30 (make-node 20 'd NONE NONE)) #false)
(check-expect (search-bt 20 NONE) #false)

; Exercise 388
(define-struct employee (name ssn pay))
(define-struct wr (name hrs))
(define-struct final (name wage))
; weekly-wage : Number Number -> Number
; multiplies the number of hours by the pay-rate
(define (weekly-wage hrs pay)
  (* hrs pay))
(check-expect (weekly-wage 10 20) 200)

(define loes1 (list (make-employee "John" 234 2)
                    (make-employee "Sean" 231 3)
                    (make-employee "Rachel" 098 4)))
(define lowr1 (list (make-wr "John" 10)
                    (make-wr "Sean" 20)
                    (make-wr "Rachel" 15)))

; wages*.v2 : [Listof EmployeeStructures] [Listof WorkRecords] -> [Listof Structures]
; creates a ListofStructures with employee names and their weekly wages
(define (wages*.v2 loes lowr)
  (cond [(empty? loes) empty]
        [else (cons (make-final (wr-name (first lowr))
                                (weekly-wage (wr-hrs (first lowr))
                                             (employee-pay (first loes))))
                    (wages*.v2 (rest loes) (rest lowr)))]))
(check-expect (wages*.v2 loes1 lowr1)
              (list (make-final "John" 20)
                    (make-final "Sean" 60)
                    (make-final "Rachel" 60)))

; Exercise 389
(define-struct phone-record (name number))
(define lona1 (list "John"
                    "Sean"
                    "Rachel"))
(define lonu1 (list "1234567"
                    "2345678"
                    "3456789"))
; zip : [Listof String] [Listof String] -> [Listof PhoneRecords]
; combines the two [Listof String] to form a [Listof PhoneRecords]
(define (zip lona lonu)
  (cond [(empty? lona) empty]
        [else (cons (make-phone-record (first lona) (first lonu))
        (zip (rest lona) (rest lonu)))]))

(check-expect (zip lona1 lonu1)
              (list (make-phone-record "John" "1234567")
                    (make-phone-record "Sean" "2345678")
                    (make-phone-record "Rachel" "3456789")))

; Exercise 390
(define-struct branch (left right))
; A TOS is one of:
; - Symbol
; - (make-branch TOS TOS)

; A Direction is one of:
; - 'left
; - 'right

(define tos1 (make-branch (make-branch 's 'a) 'd))
(define lod1 (list 'left 'right))
; tree-pick : TreeofSymbols [Listof Directions] -> [Symbol, Error]
; produces the symbol of the TreeofSymbols at the end of the ListofDirections
; produces error if symbol is reached before end of ListofDirections
(define (tree-pick TOS lod)
  (cond [(symbol? TOS)
         (cond [(empty? lod) TOS]
               [else "error"])]
        [(branch? TOS)
         (cond [(empty? lod) "error"]
               [else
                (cond [(equal? (first lod) 'right) (tree-pick (branch-right TOS)
                                                              (rest lod))]
                      [else (tree-pick (branch-left TOS)
                                       (rest lod))])])]))

(check-expect (tree-pick tos1 lod1)
              'a)
(check-expect (tree-pick tos1 (list 'left 'left 'left))
              "error")
(check-expect (tree-pick tos1 (list 'left))
              "error")

(define-struct section (title text subsections))

; A Section is (make-section String [Listof String] [Listof Section])
; where the title field is the name of the section,
; the text field is the words in the section,
; and the subsections field is the contents of the section.

(define section1 (make-section "Arthur" (list "A"
                                              "R"
                                              "T"
                                              "H"
                                              "U"
                                              "R") empty))

(define section2 (make-section "Johnny" (list "J"
                                              "O"
                                              "H"
                                              "N"
                                              "N"
                                              "Y") (list section1)))
; process-section : Section -> ???
; processes a section
(define (process-section s)
  (...
   (section-title s)
   (section-text s)
   (process-los (section-subsections s))
   ...))

; process-los : [Listof Section] -> ???
; processes a ListofSection
(define (process-los los)
  (cond [(empty? los) ...]
        [else (... (process-section (first los))
                   (process-los (rest los)) ...)]))

; has-word : [Listof String] String -> Boolean
; determines if the given ListofString contains the given string
(define (has-word los s)
  (cond [(empty? los) false]
        [else
         (cond [(string=? s (first los)) true]
               [else (has-word (rest los) s)])]))
; search-section : Section String -> [Listof String]
; returns the titles of each section that contain the given string in their text
(define (search-section sect string)
  (cond [(empty? (section-subsections sect)) empty]
        [else
         (cond [(has-word (section-text (first (section-subsections sect))) string)
                (cons (first (section-subsections sect))
                      (search-section (make-section "a"
                                                    (list "s")
                                                    (rest (section-subsections sect)))
                                      string))]
               [else (search-section (make-section "a"
                                                   (list "s")
                                                   (rest (section-subsections sect)))
                                     string)])]))

(check-expect (search-section section1 "A") empty)
(check-expect (search-section section2 "S") empty)
(check-expect (search-section section2 "A") (list section1))