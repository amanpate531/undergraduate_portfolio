;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Assignment 9|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(define width 200)
(define height 200)
(define my-points
  (build-list 11 (lambda (x) (make-posn x (expt x 2)))))
; add-points : Posn Image -> Image
; places a circle on an image at the x and y values of a given posn
(define (add-points p img)
  (place-image (circle 4 "solid" "green")
               (posn-x p)
               (posn-y p)
               img))
(check-expect (add-points (make-posn 2 3) (empty-scene 2 3))
              (place-image (circle 4 "solid" "green")
                           2 3
                           (empty-scene 2 3)))
; draw-lop : ListofPosn -> Image
; renders an image of all posns in the given ListofPosn
(define (draw-lop lop)
  (foldr add-points (empty-scene width height) lop))
(check-expect (draw-lop (list (make-posn 32 3) (make-posn 3 4)))
              (place-image (circle 4 "solid" "green")
                           32 3
                           (place-image (circle 4 "solid" "green")
                                        3 4
                                        (empty-scene 200 200))))
(define my-plot
  (draw-lop my-points))

; adjust-posn : Posn -> Posn
; changes the coordinates of a posn with respect to a origin center
(define (adjust-posn p)
  (make-posn (+ (/ width 2) (posn-x p)) (- (/ height 2) (posn-y p))))
(check-expect (adjust-posn (make-posn 100 100))
              (make-posn 200 0))
; center-origin : ListofPosn -> ListofPosn
; rearranges the coordinates of posns in a ListofPosn such that the origin is the center of the scene
(define (center-origin lop)
  (map adjust-posn lop))

(define my-centered-plot
  (draw-lop (center-origin my-points)))

; A plane is a (make-plane Number Number Number Number)
(define-struct plane (xscale yscale x0 y0))

; image-coords : Plane ListofPosn -> ListofPosn
; changes a ListofPosn according to the given plane and center-origin
(define (image-coords pl lop)
  (local [; plane-posn : Posn Plane -> Posn
          ; adjusts a posn given the parameters of a plane
          (define (plane-posn p)
            (make-posn (+ (plane-x0 pl) (* (plane-xscale pl) (posn-x p)))
                       (- height (+ (plane-y0 pl) (* (plane-yscale pl) (posn-y p))))))]
    (map plane-posn lop)))

(check-expect (image-coords (make-plane 2 1 10 10) (list (make-posn 2 3)))
              (list (make-posn 14 187)))

(define move-speed 2)
(define zoom-factor 1.2)
(define init-plane (make-plane 1 1 100 100))
; navigate : Plane KeyEvent -> Plane
; alters the xscale and yscale of a plane depending on the keyevent
(define (navigate pl ke)
  (cond [(equal? ke "up") (make-plane (plane-xscale pl)
                                      (plane-yscale pl)
                                      (plane-x0 pl)
                                      (+ (plane-y0 pl) move-speed))]
        [(equal? ke "down") (make-plane (plane-xscale pl)
                                        (plane-yscale pl)
                                        (plane-x0 pl)
                                        (- (plane-y0 pl) move-speed))]
        [(equal? ke "left") (make-plane (plane-xscale pl)
                                        (plane-yscale pl)
                                        (- (plane-x0 pl) move-speed)
                                        (plane-y0 pl))]
        [(equal? ke "right") (make-plane (plane-xscale pl)
                                         (plane-yscale pl)
                                         (+ (plane-x0 pl) move-speed)
                                         (plane-y0 pl))]
        [(equal? ke "w") (make-plane (plane-xscale pl)
                                     (* zoom-factor (plane-yscale pl))
                                     (plane-x0 pl)
                                     (plane-y0 pl))]
        [(equal? ke "a") (make-plane (/ (plane-xscale pl) zoom-factor)
                                     (plane-yscale pl)
                                     (plane-x0 pl)
                                     (plane-y0 pl))]
        [(equal? ke "s") (make-plane (plane-xscale pl)
                                     (/ (plane-yscale pl) zoom-factor)
                                     (plane-x0 pl)
                                     (plane-y0 pl))]
        [(equal? ke "d") (make-plane (* zoom-factor (plane-xscale pl))
                                     (plane-yscale pl)
                                     (plane-x0 pl)
                                     (plane-y0 pl))]
        [(equal? ke "r") init-plane]))
(check-expect (navigate init-plane "left") (make-plane 1 1 98 100))
(check-expect (navigate init-plane "right")(make-plane 1 1 102 100))
(check-expect (navigate init-plane "up")(make-plane 1 1 100 102))
(check-expect (navigate init-plane "down")(make-plane 1 1 100 98))
(check-expect (navigate init-plane "w")(make-plane 1 1.2 100 100))
(check-expect (navigate init-plane "a")(make-plane (/ 5 6) 1 100 100))
(check-expect (navigate init-plane "s")(make-plane 1 (/ 5 6) 100 100))
(check-expect (navigate init-plane "d")(make-plane 1.2 1 100 100))
(check-expect (navigate init-plane "r")(make-plane 1 1 100 100))
                        
; helper-draw : Plane -> Image
; renders an image of my-points using image-coords and draw-lop
(define (helper-draw pl)
  (draw-lop (image-coords pl my-points)))

(define my-interactive-plot
  (big-bang init-plane
            [to-draw helper-draw]
            [on-key navigate]))
; xticks : Number Number Number -> ListofNumber
; produces an increasing ListofNumber using the three given numbers
(define (xticks xscale x0 n)
  (cond [(= n 0) empty]
        [else (cons (+ (- 0 (/ x0 xscale)) (* (sub1 n) (/ 1 xscale)))
                    (xticks xscale x0 (sub1 n)))]))

(check-expect (xticks 10 10 5)
              (list -0.6 -0.7 -0.8 -0.9 -1))
; graph : [Number -> Number] ListofNumber -> ListofPosn
; applies the given function to the given ListofNumber to form a ListofPosn
(define (graph f lon)
  (map (lambda(x) (make-posn x (f x))) lon))

(check-expect (graph sqr (list 1 2 3))
              (list (make-posn 1 1)
                    (make-posn 2 4)
                    (make-posn 3 9)))
; draw-graph : Plane [Number -> Number] -> Image
; combines the functions draw-lop, image-coords, graph, and xticks
(define (draw-graph pl f)
  (draw-lop (image-coords pl (graph f (xticks (plane-xscale pl)
                                              (plane-x0 pl)
                                              (add1 width))))))

; draw-graph-sin : Plane -> Image
; creates a one-variable function for use with big-bang
(define (draw-graph-sin pl)
  (draw-graph pl sin))

(define interactive-sin
  (big-bang init-plane
            [on-key navigate]
            [to-draw draw-graph-sin]))
; Press "w" 24 times and "a" 10 times to find sin curve