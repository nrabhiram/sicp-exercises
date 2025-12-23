#lang sicp

(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define test-interval (make-interval 5 10))
(display (lower-bound test-interval)) (newline)
(display (upper-bound test-interval))