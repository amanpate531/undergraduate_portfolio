;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Demonstration 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
;
(define sun (circle 100 "solid" "yellow"))
(define (moon size) (circle (min 100 size) "solid" "black"))
;(check-expect (moon 3) (circle 3 "solid" "black"))
;(define (three-moons szs) (overlay (beside (moon szs) (moon szs) (moon szs)) (empty-scene 400 400)))
;
;(animate three-moons)
;
;(check-expect (moon 120120120102) (circle 50 "solid" "black"))

(define (eclipse time)
  (place-image
   (moon 95)
   (- 500 time) 250
   (overlay sun (empty-scene 500 500))))

(animate eclipse)
