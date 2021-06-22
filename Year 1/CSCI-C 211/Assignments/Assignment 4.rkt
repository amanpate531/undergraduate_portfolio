;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Assignment 4|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/string)

; draw-string : String -> Image of String 
; Takes a string and makes it a certain size and color
(define (draw-string s)
  (text s 45 "blue"))

(check-expect (draw-string "blue") (text "blue" 45 "blue"))

; add : String -> String
; Takes the previous string and adds a "g" on the end
(define (add s ke)
  (cond [(string=? ke " ") ""]
        [else (string-append s "g")]))

(check-expect (add "blue" " ") "")
(check-expect (add "blue" "a") "blueg")

;(big-bang "omg"
;          [on-key add]
;          [to-draw draw-string])

;(define-struct date (year month day)) defines the following functions:

; - (date? (make-date ...)) Date -> Boolean
; - (make-date ...) Number String Number -> Date
; - (date-year (make-date ...)) Date -> Number
; - (date-month (make-date ...)) Date -> String
; - (date-day (make-date ...)) Date -> Number


(define-struct address (number street city state))

(define (process-address address)
  (string-append (number->string (address-number address))
                 " "
                 (address-street address)
                 ", "
                 (address-city address)
                 ", "
                 (address-state address)))

(define (address-even address)
  (cond [(even? (address-number address)) "yes"]
        [else "no"]))

(check-expect (address-even r) "no")
(check-expect (address-even
               (make-address 1234 "Pennsylvania" "Princeton" "New Jersey"))
              "yes")
               
(define r (make-address 2341 "Wilson" "Muncie" "Indiana"))
(define s (make-address 1234 "Rose" "Bloomington" "Indiana"))

(define (address-small address1 address2)
  (cond [(< (- (address-number address1)
               (address-number address2)) 0)
         (process-address address1)]
        [else (process-address address2)]))

(check-expect (address-small s r) (process-address s))
(check-expect (address-small r s) (process-address s))

(define (address-string address)
  (process-address address))

(check-expect (address-string r)
              "2341 Wilson, Muncie, Indiana")

; Book Exercises

; Exercise 83

(define-struct editor (pre post))
(define (render editor)
  (place-image (rectangle 1 20 "solid" "red")
               (* (+ 1 (string-length (editor-pre editor))
                               (string-length (editor-post editor))) 3.5)
               10
               (place-image (text
                (string-append
                 (editor-pre editor)
                 " "
                 (editor-post editor))
                16 "black") (* (+ 1 (string-length (editor-pre editor))
                               (string-length (editor-post editor))) 3.5)
                                              10 (empty-scene 200 20))))

(check-expect (render t)
              (place-image (rectangle 1 20 "solid" "red")
               (* (+ 1 (string-length "hello")
                               (string-length "world")) 3.5)
               10
               (place-image (text
                (string-append
                 "hello"
                 " "
                 "world")
                16 "black") (* (+ 1 (string-length "hello")
                               (string-length "world")) 3.5)
                                              10 (empty-scene 200 20))))
              
(define t (make-editor "hello" "world"))

(define (string-last s)
  (string-ith s (- (string-length s) 1)))

(check-expect (string-last "french") "h")

(define (string-first s)
  (string-ith s 0))

(check-expect (string-first "french") "f")

(define (edit ed ke)
  (cond [(string=? "\b" ke) (string-append (string-replace
                             (editor-pre ed)
                             (string-last (editor-pre ed)) "") " " (editor-post ed)) ]
        [(= (string-length ke) 1)
         (string-append (editor-pre ed) ke " " (editor-post ed))]
        [(string=? "left" ke)
         (place-image (rectangle 1 20 "solid" "red")
               (- (* (+ 1 (string-length (editor-pre ed))
                               (string-length (editor-post ed))) 3.5) 8)
               10
               (place-image (text
                (string-append
                 (editor-pre ed)
                 " "
                 (editor-post ed))
                16 "black") (* (+ 1 (string-length (editor-pre ed))
                               (string-length (editor-post ed))) 3.5)
                                              10 (empty-scene 200 20)))]
         [(string=? "right" ke)
          (place-image (rectangle 1 20 "solid" "red")
               (+ (* (+ 1 (string-length (editor-pre ed))
                               (string-length (editor-post ed))) 3.5) 8)
               10
               (place-image (text
                (string-append
                 (editor-pre ed)
                 " "
                 (editor-post ed))
                16 "black") (* (+ 1 (string-length (editor-pre ed))
                               (string-length (editor-post ed))) 3.5)
                                              10 (empty-scene 200 20)))]))

(check-expect (edit (make-editor "john" "doe") "\b") "joh doe")
(check-expect (edit (make-editor "john" "doe") "a") "johna doe")
(check-expect (edit (make-editor "john" "doe") "right") (place-image (rectangle 1 20 "solid" "red")
               (+ (* (+ 1 (string-length "john")
                               (string-length "doe")) 3.5) 8)
               10
               (place-image (text
                (string-append
                 "john"
                 " "
                 "doe")
                16 "black") (* (+ 1 (string-length "john")
                               (string-length "doe")) 3.5)
                                              10 (empty-scene 200 20))))
(check-expect (edit (make-editor "john" "doe") "left") (place-image (rectangle 1 20 "solid" "red")
               (- (* (+ 1 (string-length "john")
                               (string-length "doe")) 3.5) 8)
               10
               (place-image (text
                (string-append
                 "john"
                 " "
                 "doe")
                16 "black") (* (+ 1 (string-length "john")
                               (string-length "doe")) 3.5)
                                              10 (empty-scene 200 20))))

(big-bang (make-editor "pre" "post")
            [on-key edit]
            [to-draw render])