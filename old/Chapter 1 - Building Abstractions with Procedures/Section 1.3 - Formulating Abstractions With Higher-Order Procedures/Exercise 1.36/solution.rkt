#lang sicp

(define (fixed-point f initial-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
     (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next-guess (f guess)))
      (cond ((close-enough? guess next-guess)
             (newline)
             (display next-guess)
             (newline)
             (display "--- COMPUTATION ENDED ---")
             (newline)
             next-guess)
            (else
             (newline)
             (display guess)
             (try next-guess)))))
  (try initial-guess))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2)
(fixed-point (lambda (x) (/ (+ (/ (log 1000) (log x)) x) 2.0)) 2)