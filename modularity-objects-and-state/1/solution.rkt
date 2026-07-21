#lang sicp

(define (make-accumulator n)
  (lambda (x)
    (set! n (+ n x))
    n))

(define A (make-accumulator 5))
(define B (make-accumulator 100))
(A 10)
(A 10)
(B 1)
(A 1)
