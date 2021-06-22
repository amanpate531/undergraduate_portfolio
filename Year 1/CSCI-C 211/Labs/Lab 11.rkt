;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lab 11|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/json)

; read-json/web : String -> JSON
; Retrieves the remote file at the given URL and returns JSON data

; read-json/file : String -> JSON
; Retrieves the local file with the given name and returns JSON data

; A JSON is one of:
; - (make-null)
; - Boolean
; - String
; - Number
; - [Listof JSON]
; - (make-object [Listof Member])

; A Member is [List String JSON]

; parse : Anything -> JSON
; returns the current data found from the source
(define (parse a)
  (read-json/web "http://iub.doublemap.com/map/v2/buses"))

; process-JSON : JSON -> ???
; processes a JSON
(define (process-JSON json)
  (cond [(null? json) ...]
        [(boolean? json)
         (cond [(equal? json true) ...]
               [(equal? json false) ...])]
        [(string? json) ...]
        [(number? json) ...]
        [(list? json) (process-list json)]
        [(object? json) (process-members (object-members json))]))

; process-list : [Listof JSON] -> ???
; processes a ListofJSON
(define (process-list loj)
  (cond [(empty? loj) ...]
        [else (... (process-JSON (first loj)) (process-list (rest loj)) ...)]))

; process-members : [Listof Members] -> ???
; processes a ListofMembers
(define (process-members lom)
  (cond [(empty? lom) ...]
        [else (... (first (first lom))
                   (process-JSON (first (rest (first lom))))
                   (process-members (rest lom)) ...)]))
        
; clean : JSON -> JSON
; returns the same JSON, but each JSON that is a string is changed to "censored"
(define (clean json)
  (cond [(null? json) json]
        [(boolean? json)
         (cond [(equal? json true) json]
               [(equal? json false) json])]
        [(string? json) "censored"]
        [(number? json) json]
        [(list? json) json]
        [(object? json) json]))

;(clean (parse "s"))

; helper-lom : [Listof Member] String -> JSON
; searches a ListofMember for a specific string and returns the number within the corresponding JSON
(define (helper-lom lom s)
  (cond [(string=? s (first (first lom))) (first (rest (first lom)))]
        [else (helper-lom (rest lom) s)]))
; project : JSON -> [Listof Posn]
; returns a ListofPosn with the lat and lon coords of each object
(define (project json)
  (cond [(empty? json) empty]
        [else (cons (make-posn (helper-lom (object-members (first json)) "lat")
                               (helper-lom (object-members (first json)) "lon"))
                    (project (rest json)))]))

;(project (parse "a"))

(define WIDTH 200)
(define HEIGHT 200)
; transform (make-posn 39.162222 -86.529167) into (make-posn 100 100)
; transform : Posn -> Posn
; converts a Posn from Earth coords to Racket-compatible coords
(define (transform psn)
  (make-posn (+ 100
                (* 100 (/ (- (posn-x psn) 39.162222) 0.02)))
             (- 100
                (* 100 (/ (- (posn-y psn) -86.529167) 0.02)))))
(check-expect (transform (make-posn 39.162222 -86.529167)) (make-posn 100 100))
(check-expect (transform (make-posn 39.162222 -86.509167)) (make-posn 100 0))
(check-expect (transform (make-posn 39.142222 -86.509167)) (make-posn 0 0))
(check-expect (transform (make-posn 39.142222 -86.529167)) (make-posn 0 100))
(check-expect (transform (make-posn 39.142222 -86.519167)) (make-posn 0 50))

(require 2htdp/image)

(define bus (circle 5 "solid" "green"))
; draw-lop : JSON -> Image
; renders an image of the given JSON
(define (draw-lop JSON)
(cond [(empty? JSON) (empty-scene WIDTH HEIGHT)]
      [else (place-image bus
                         (posn-x (transform (first (project JSON))))
                         (posn-y (transform (first (project JSON))))
                         (draw-lop (rest JSON)))]))

(check-expect (draw-lop empty)
              (empty-scene 200 200))
(require 2htdp/universe)
(define bus-now
  (big-bang empty
            [to-draw draw-lop]
            [on-tick parse 1]))

; has-posn? : [Listof X] : Boolean
; determines if the given list contains a posn
(define (has-posn? lox)
  (cond [(empty? lox) false]
        [else
         (cond [(posn? (first lox)) true]
               [else (has-posn? (rest lox))])]))
(check-expect (has-posn? (list "a" "sd" "a" 1)) false)
(check-expect (has-posn? empty) false)
(check-expect (has-posn? (list 1 2 3 4 (make-posn 1 2))) true)
; json? : Anything -> Boolean
; returns Boolean based on whether or not the input is a JSON
(define (json? a)
  (cond [(null? a) true]
        [(boolean? a) true]
        [(string? a) true]
        [(number? a) true]
        [(object? a) true]
        [(list? a)
         (cond [(equal? (has-posn? a) true) false]
               [(empty? a) false]
               [else true])]
        [else false]))

(check-expect (json? "A") true)
(check-expect (json? (make-null)) true)
(check-expect (json? 2) true)
(check-expect (json? true) true)
(check-expect (json? (make-object empty)) true)
(check-expect (json? empty) false)
(check-expect (json? (list "A" 1 2 3 4)) true)
(check-expect (json? (list "A" 1 2 3 (make-posn 2 3))) false)
(check-expect (json? (make-posn 2 3)) false)