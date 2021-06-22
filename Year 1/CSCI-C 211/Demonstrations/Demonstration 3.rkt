;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Demonstration 3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(define ROCKET (above (triangle 15 "solid" "black")
                      (square 15 "solid" "red")))
(define BACKGROUND (empty-scene 500 500))

;; 1. Data Definition

;; A Time is one of:
;;  - A Number less than 100
;;  - A Number greater than or equal to 100

;; 2. Signature, Purpose, Header

;; place-rocket : Time -> Image
;; put the rocket at the appropriate height for the given time


;; 3. Examples
(check-expect (place-rocket 0)
              (place-image ROCKET 250 (- 0 15) BACKGROUND))
(check-expect (place-rocket 100)
              (place-image ROCKET 250 485 BACKGROUND))
(check-expect (place-rocket 150)
              (place-image ROCKET 250 435 BACKGROUND))

;; 4. Template
(define (place-rocket t)
  (cond [(< t 100)
         (place-image ROCKET 250 (+ -115 (* 6 t)) BACKGROUND)]
        [else
         (place-image ROCKET 250 (- 585 (* 12 t)) BACKGROUND)]))






  ;; (place-image ROCKET 250 (+ -115 (* 6 t)) BACKGROUND))

(animate place-rocket)
