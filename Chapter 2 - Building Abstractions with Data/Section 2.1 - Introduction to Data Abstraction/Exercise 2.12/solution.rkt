#lang sicp

(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (make-center-percent c p)
  (let ((factor (/ p 100.0)))
    (make-interval (- c (* c factor))
                   (+ c (* c factor)))))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (let ((center (center i))
        (upper-bound (upper-bound i)))
    (* (/ (- upper-bound center) center) 100)))

(define test-interval (make-center-percent 100 5))
(lower-bound test-interval)
(upper-bound test-interval)
(center test-interval)
(percent test-interval)