;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Assignment 13|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; add-x : Number -> [Number Number -> Number]
; uses the given number to create a new addition function
(define (add-x n)
  (lambda (x) (+ x n)))
(check-expect ((add-x 3) 2) 5)
; add-to-each : [Listof Number] Number -> [Listof Number]
; adds the given number to every element in the given list
(define (add-to-each l n)
  (map (add-x n) l))
(check-expect (add-to-each (list 1 2 3) 3) (list 4 5 6))

; overdraw? : [Listof Number] -> Boolean
; determines if the balance of the account ever becomes negative
(define (overdraw? l)
  (cond [(empty? l) false]
        [(= (length l) 1)
         (cond [(< (first l) 0) true]
               [else false])]
        [else
         (cond [(> 0 (+ (first l) (first (rest l)))) true]
               [else (overdraw? (cons (+ (first l) (first (rest l)))
                                      (rest (rest l))))])]))

(check-expect (overdraw? empty) false)
(check-expect (overdraw? (list 10)) false)
(check-expect (overdraw? (list -10)) true)
(check-expect (overdraw? (list 10 -11 0)) true)
(check-expect (overdraw? (list 10 20 32)) false)

; digits->number : [Listof Number] -> Number
; compiles all of the single digits in the given list into a number
; (define (digits->number l)
;   (cond []

;; A RadioShow is (make-rs String Number [ListOf Ad])
(define-struct rs (name minutes ads))
 
;; An Ad is (make-ad String Number Number)
(define-struct ad (name minutes profit))
 
;; Examples of data:
 
(define ipod-ad (make-ad "ipod" 2 100))
(define ms-ad (make-ad "ms" 1 500))
(define xbox-ad (make-ad "xbox" 2 300))
 
(define news-ads (list ipod-ad ms-ad ipod-ad xbox-ad))
(define game-ads (list ipod-ad ms-ad ipod-ad ms-ad xbox-ad ipod-ad))
(define bad-ads (list ipod-ad ms-ad ms-ad ipod-ad xbox-ad ipod-ad))
 
(define news (make-rs "news" 60 news-ads))
(define game (make-rs "game" 120 game-ads))
 
; total-time-acc : [Listof Ad] -> Number
; computes the total time for all ads in the given list
(define (total-time-acc adlist0)
  (local [(define (total-time-acc adlist acc)
            (cond [(empty? adlist) acc]
                  [else (total-time-acc (rest adlist)
                                    (+ acc (ad-minutes (first adlist))))]))]
(total-time-acc adlist0 0)))

(check-expect (total-time-acc news-ads) 7)
(check-expect (total-time-acc game-ads) 10)

; total-profit-ads : [Listof Ad] -> Number
; computes the total profit for all ads in the given list
(define (total-profit-ads adlist0)
  (local [(define (total-profit-ads adlist acc)
            (cond [(empty? adlist) acc]
                  [else (total-profit-ads (rest adlist)
                                      (+ acc (ad-profit (first adlist))))]))]
    (total-profit-ads adlist0 0)))

(check-expect (total-profit-ads news-ads) 1000)
(check-expect (total-profit-ads game-ads) 1600)

; total-profit : RadioShow -> Number
; computes the total profit for the given RadioShow
(define (total-profit rs)
  (total-profit-ads (rs-ads rs)))

(check-expect (total-profit news) 1000)
; no-repeat : [Listof Ad] -> Boolean
; determines if any two consecutive ads are the same
(define (no-repeat adlist0)
  (local [(define (no-repeat adlist acc)
            (cond [(empty? adlist) true]
                  [else
                   (cond [(string=? (ad-name (first adlist)) acc)
                          false]
                         [else (no-repeat (rest adlist)
                                          (ad-name (first adlist)))])]))]
    (no-repeat adlist0 "acc")))

(check-expect (no-repeat bad-ads) false)
(check-expect (no-repeat news-ads) true)

; Exercise 6
; The accumulator is not needed to write no-repeat
(define (no-repeat1 adlist)
  (cond [(empty? adlist) true]
        [(= (length adlist) 1) true]
        [else
         (cond [(string=? (ad-name (first adlist))
                          (ad-name (first (rest adlist))))
                false]
               [else (no-repeat1 (rest adlist))])]))

(check-expect (no-repeat1 bad-ads) false)
(check-expect (no-repeat1 news-ads) true)
(check-expect (no-repeat1 empty) true)

; A BinaryTree is one of:
; - (make-leaf Number)
; - (make-node Number BinaryTree BinaryTree)
(define-struct leaf [n])
(define-struct node [n l r])

(define bt1 (make-node 3 (make-leaf 4) (make-leaf 5)))
;(check-expect (path-sum bt1)
;              (make-node 3 (make-leaf 7) (make-leaf 8)))
 
(define bt2 (make-node 100 bt1 (make-leaf 10)))
;(check-expect (path-sum bt2)
;              (make-node 100 (make-node 103 (make-leaf 107) (make-leaf 108))
;                             (make-leaf 110)))
; path-sum : BinaryTree -> BinaryTree
; replaces each number with the sum of all the numbers on the path
; between the root of the tree and the original number
;(define (path-sum bt0)
;  (local [(define (path-sum bt acc)
;            (cond [(leaf? bt) bt]
;                  [else]]

; A RailForest is a [ListOf RailTree]
; A RailTree is (make-tree Number String RailForest)
(define-struct tree [distance station forest])
 
(define atlanta-five-points
  (list (make-tree 7 "Airport" empty)
        (make-tree 9 "Indian Creek" empty)
        (make-tree 6 "Lindbergh Center"
          (list (make-tree 5 "North Springs" empty)
                (make-tree 4 "Doraville" empty)))
        (make-tree 3 "Ashby"
          (list (make-tree 2 "H.E. Holmes" empty)
                (make-tree 1 "Bankhead" empty)))))
 
(define kaohsiung-main
  (list (make-tree 14 "Gangshan South" empty)
        (make-tree 1 "Formosa"
          (list (make-tree 3 "Sizihwan" empty)
                (make-tree 8 "Siaogang" empty)
                (make-tree 10 "Daliao" empty)))))

; add-tree : Tree -> Tree
; adds the tree distance to the given accumulator
(define (add-tree t)
  (make-tree (lambda (acc) (+ (tree-distance t) acc))
             (tree-station t)
             (tree-forest t)))
; forest-rel->abs : RailForest -> RailForest
; changes the distances from between stops to from root to each stop
(define (forest-rel->abs rf0)
  (local [(define (forest-rel->abs rf acc)
            (cond [(empty? rf) empty]
                  [else
                   (cons (fn-for-tree (first rf) (tree-distance (first rf)))
                         (forest-rel->abs (rest rf) 0))]))
          (define (fn-for-tree t acc)
            (cond [(empty? (tree-forest t)) t]
                  [else (make-tree (tree-distance t)
                                   (tree-station t)
                                   (map (add-tree acc) (tree-forest t)))]))]
    (forest-rel->abs rf0 0)))


          
