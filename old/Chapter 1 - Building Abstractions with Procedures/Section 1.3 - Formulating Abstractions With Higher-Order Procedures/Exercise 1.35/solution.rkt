#lang sicp

(define (fixed-point f initial-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
     (< (abs (- v1 v2)) tolerance))
   (define (try guess)
     (let ((next-guess (f guess)))
       (if (close-enough? guess next-guess)
           next-guess
           (try next-guess))))
   (try initial-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)