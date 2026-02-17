#lang sicp

(define tolerance 0.00001)

(define (fixed-point f initial-guess)
  (define (close-enough? a b)
    (let ((delta (- a b)))
      (< (abs delta) tolerance)))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? next guess)
          next
          (try next))))

  (try initial-guess))

(fixed-point
  (lambda (x) (+ 1 (/ 1 x)))
  1.0)
