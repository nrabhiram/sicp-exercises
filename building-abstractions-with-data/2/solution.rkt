#lang sicp

(define (average x y)
  (/ (+ x y) 2))

(define (make-point x y) (cons x y))
(define (x-point pt) (car pt))
(define (y-point pt) (cdr pt))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))

(define (make-segment start end) (cons start end))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (midpoint-segment s)
  (make-point (average (x-point (start-segment s))
                       (x-point (end-segment s)))
              (average (y-point (start-segment s))
                       (y-point (end-segment s)))))

;; Tests
(define p1 (make-point 0 0))
(define p2 (make-point 4 6))
(define s1 (make-segment p1 p2))
(define mid1 (midpoint-segment s1))
(display "Test 1 - midpoint of (0,0)-(4,6): ")
(print-point mid1) ; expect (2,3)

(define s2 (make-segment (make-point -2 -3) (make-point 4 7)))
(define mid2 (midpoint-segment s2))
(display "Test 2 - midpoint of (-2,-3)-(4,7): ")
(print-point mid2) ; expect (1,2)

(define s3 (make-segment (make-point 1 1) (make-point 1 1)))
(define mid3 (midpoint-segment s3))
(display "Test 3 - midpoint of same point (1,1)-(1,1): ")
(print-point mid3) ; expect (1,1)

(define s4 (make-segment (make-point 0 0) (make-point 3 5)))
(define mid4 (midpoint-segment s4))
(display "Test 4 - midpoint of (0,0)-(3,5): ")
(print-point mid4) ; expect (3/2,5/2)
