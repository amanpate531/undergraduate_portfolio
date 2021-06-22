;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Demonstration 5 Part 1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Structures and Unions

; A Book is(make-book String String PositiveNumber)
(define-struct book (title author year))
(book? ...) ; Anything -> Boolean
(make-book ... ... ...) ; String String PositiveNumber -> Book
(book-title ...) ; Book -> String
(book-author ...) ; Book -> String
(book-year ...) ; Book -> PositiveNumber

; process-book : Book -> ???
(define (process-book b)
  (book-title b) ... (book-author b) ... (book-year b))
