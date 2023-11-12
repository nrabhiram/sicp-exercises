#lang sicp

(define (average x y)
  (/ (+ x y)
     2.0))

(define (make-point x y) (cons x y))
(define (x-point pt) (car pt))
(define (y-point pt) (cdr pt))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

(define (make-segment start end) (cons start end))
(define (start-segment segt) (car segt))
(define (end-segment segt) (cdr segt))

(define (midpoint-segment segt)
  (let ((x-1 (car (car segt)))
        (y-1 (cdr (car segt)))
        (x-2 (car (cdr segt)))
        (y-2 (cdr (cdr segt))))
    (make-point (average x-1 x-2)
                (average y-1 y-2))))

(define first-point (make-point 3 7))
(define second-point (make-point 4 3))
(define segment (make-segment first-point second-point))
(define midpoint (midpoint-segment segment))
(print-point midpoint)