;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Lab 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define (tilted-star deg)
  (rotate deg (star 100 "solid" "goldenrod")))

; Exercise 1: (define (flickering-tilted-star deg)
;                (rotate deg (star 100 "solid" (cond [(even? deg) "goldenrod"] [else "white"]))))
;(animate flickering-tilted-star)

; 1. Data Definition

; A dB is one of:
; - A Number between 30 and 39
; - A Number between 60 and 69
; - A Number between 98 and 99
; - A Number between 101 and 105
; - A Number between 145 and 149
; - A Number between 150 and 154
; - A Number between 280 and 300
; - A Number greater than 1000

; 2. Signature, Purpose, Header

; decibel : Number -> String
; display the appropriate noise for the given decibel value

;(define (decibel dB)
;  (cond [(and (>= dB 30) (<= dB 39)) "Whispering"]
;        [(and (>= dB 60) (<= dB 69)) "Television"]
;        [(and (>= dB 98) (<= dB 99)) "Honda S2000 Factory Exhaust"]
;        [(and (>= dB 101) (<= dB 105)) "Ferrari 458 Factory Exhaust"]
;        [(and (>= dB 145) (<= dB 149)) "McDonnell Douglas F-15C at takeoff"]
;        [(and (>= dB 150) (<= dB 154)) "Lockheed Martin F-35B at hover"]
;        [(and (>= dB 280) (<= dB 300)) "Thermonuclear warhead"]
;        [(> dB 1000) "Disaster Area, heard from a concrete bunker 37 mi away"]
;        [else (error "Not Within Range")]))
       

; 3. Examples
;(check-error (decibel 23)
;              "Not Within Range")
;(check-expect (decibel 104)
;              "Ferrari 458 Factory Exhaust")
;(check-expect (decibel 10132)
;              "Disaster Area, heard from a concrete bunker 37 mi away")
;(check-expect (decibel 148)
;              "McDonnell Douglas F-15C at takeoff")
;(check-expect (decibel 152)
;              "Lockheed Martin F-35B at hover")
;(check-expect (decibel 35)
;              "Whispering")
;(check-expect (decibel 64)
;              "Television")
;(check-expect (decibel 295)
;              "Thermonuclear warhead")
;(check-expect (decibel 98)
;              "Honda S2000 Factory Exhaust")

(define (draw-shape shape color size)
  (cond [(string=? shape "circle") (circle size "solid" color)]
        [(string=? shape "box") (square size "solid" color)]
        [(string=? shape "triangle") (circle size "solid" color)]))

(check-expect (draw-shape "circle" "blue" 14)
              (circle 14 "solid" "blue"))
(check-expect (draw-shape "box" "green" 123)
              (square 123 "solid" "green"))

; 1. Data Definition

; An image is one of:
; - A shape created in DrRacket
; - An image downloaded from the web

; 2. Signature, Purpose, Header
; red-frame : Image -> Image
; Overlays an image over a white square then over a larger red square to create a red frame

(define (red-frame image)
  (overlay image
           (square 101 "solid" "white")
           (square 104 "solid" "red")))

; 3. Examples

(check-expect (red-frame (circle 50 "solid" "blue"))
                         (overlay (circle 50 "solid" "blue")
                                  (square 101 "solid" "white")
                                  (square 104 "solid" "red")))
(check-expect (red-frame (square 49 "solid" "green"))
              (overlay (square 49 "solid" "green")
                       (square 101 "solid" "white")
                       (square 104 "solid" "red")))
(check-expect (red-frame (circle 32 "outline" "black"))
              (overlay (circle 32 "outline" "black")
                       (square 101 "solid" "white")
                       (square 104 "solid" "red")))

                     





