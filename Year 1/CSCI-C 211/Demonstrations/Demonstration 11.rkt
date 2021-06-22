;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Demonstration 11|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Abstraction

; A [Listof X] is one of:
; - empty
; - (cons X [Listof X])

; A ListofNumbers is [Listof Number]

; A ListofStrings is [Listof String]

; A TreeofNumber is one of:
; - (make-empty-tree Number)
; - (make-node TreeofNumber TreeofNumber)

; A TreeofString is one of:
; - (make-empty-tree String)
; - (make-node TreeofString TreeofString)

; A [Treeof X] is one of:
; - (make-empty-tree X)
; - (make-node [Treeof X] [Treeof X])

; ll: [Listof [Listof Number]]
(define ll empty)
(define ll2 (cons (cons 112 empty) empty))

; math : [Listof X] X [X X -> X] -> X
; apply the given operation to every element in the listofnumber
(define (math lon base op)
  (cond [(empty? lon) base]
        [else (op (first lon)
                  (math (rest lon) base op))]))

(require 2htdp/image)
(require 2htdp/universe)

; glue : [Listof String] -> String
; append all strings together
(define (glue los)
  (math los "" string-append))
  #;
  (cond [(empty? los) ""]
        [else (string-append (first los)
                             (glue (rest los)))]))
(check-expect (glue empty) "")
(check-expect (glue (list "hi" "bye")) "hibye")