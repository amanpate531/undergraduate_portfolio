;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Demonstration 8|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A ManyStrings is one of:
; - (make-no-strings)
; - (make-some-strings String ManyStrings)

(define-struct no-strings ())
(define-struct some-strings (one more))

; process-many-strings : ManyStrings -> ???
;(define (process-many-strings ms)
;  (cond
;    [(no-strings? ms) ...]
;    [else (some-strings-one ms)
;          (process-many-strings
;           (some-strings-more ms))]))

; count-strings : ManyStrings -> Number
; count how many strings are in the given ManyStrings
(define (count-strings ms)
  (cond
    [(no-strings? ms) 0]
    [else (add1 (count-strings
           (some-strings-more ms)))]))

(check-expect (count-strings (make-no-strings)) 0)
(check-expect (count-strings (make-some-strings "green" (make-no-strings))) 1)

; A BunchofImages is one of:
; - (make-zero-images)
; - (make-an-image Image BunchofImages)

(define-struct zero-images ())
(define-struct an-image (this those))

; process-bi : BunchofImages -> ???
(define (process-bi bi)
  (cond
    [(zero-images? bi) ...]
    [else (process-bi (an-image-those bi))]))

(require 2htdp/image)

; overlay-all : BunchofImages -> Image
; overlay all images on top of each other
(define (overlay-all bi)
 (cond
   [(zero-images? bi) (empty-scene 500 500)]
   [else (overlay (an-image-this bi)
         (overlay-all (an-image-those bi)))]))

(check-expect (overlay-all (make-zero-images))
              (empty-scene 500 500))
(check-expect (overlay-all (make-an-image
                            (circle 10 "solid" "red")
                            (make-zero-images)))
              (overlay (circle 10 "solid" "red")
                       (empty-scene 500 500)))

; A ListOfStrings is one of:
; - empty
; - (cons String ListOfStrings)

; process-los : ListOfStrings -> ???
;(define (process-los los)
;  (cond [(empty? los) ...]
;        [(cons? los) ...
;         (first los)
;         (process-los (rest los))]))

; count-strings2 :


;(check-expect (count-strings2 empty) 0)
;(check-expect (count-strings2 (cons "c211" empty)) 1)

; A ListofImages is one of:
; - empty
; - (cons Image ListofImages)

; overlay-all2 : ListofImages -> Image
; overlay all the images in the given list
(define (overlay-all2 loi)
  (cond
    [(empty? loi) (empty-scene 500 500)]
    [else (overlay (first loi)
                   (overlay-all2 (rest loi)))]))

; A NumberorString is one of:
; - Number
; - String

; A ListofNumberOrString is one of:
; - empty
; - (cons NumberorString ListofNumberorString)

(define l1 (cons 1 (cons "hello" (cons 3 empty))))

; remove-numbers : ListofNumberorString -> ListofStrings
; take all the numbers out of the given list
(define (remove-numbers lons)
  (cond
    [(empty? lons) empty]
    [else (helper (first lons)
          (remove-numbers (rest lons)))]))
(check-expect (remove-numbers empty) empty)
(check-expect (remove-numbers l1)
              (cons "hello" empty))

; helper : NumberorString ListofString -> ListofStrings
; adds the numberorstring to the list if it's a string
(define (helper ns los)
  (cond
    [(string? ns) (cons ns los)]
    [else los]))
(check-expect (helper 78 empty) empty)
(check-expect (helper "red" empty) (cons "red" empty))

