;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Demonstration 4 Part 1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Consider a rocket that is either resting on its launchpad
; or in flight at a certain height
(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 400)
(define WIDTH 300)

(define ROCKET (above (triangle 20 "solid" "lightgray")
                      (rectangle 20 80 "solid" "white")))

(define OFFSET 50)

(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "black"))

(check-expect (draw-in-flight 0)
              (place-image ROCKET (/ WIDTH 2)
                           (- HEIGHT OFFSET) BACKGROUND))
(check-expect (draw-in-flight 50)
              (place-image ROCKET (/ WIDTH 2)
                           (- HEIGHT OFFSET 50) BACKGROUND))

(define (draw-in-flight h)
  (place-image ROCKET (/ WIDTH 2)
               (- HEIGHT OFFSET h) BACKGROUND))

(check-expect (draw-rocket "resting")
              (draw-in-flight 0))
(check-expect (draw-rocket 50)
              (draw-in-flight 50))

(define (draw-rocket s)
  (cond
    [(string? s) (draw-in-flight 0)]
    [else (draw-in-flight s)]))

(check-expect (launch "resting" "space") 0)
(check-expect (launch 50 "A") 0)

(define (launch s ke)
  (cond
    [(string? s) 0]
    [else 0]))

(check-expect (fly "resting") "resting")
(check-expect (fly 50) 51)

(define (fly s)
  (cond
    [(string? s) "resting"]
    [else (+ 1 s)]))

(big-bang "resting"
          [on-tick fly]
          [on-key launch]
          [to-draw draw-rocket])




               