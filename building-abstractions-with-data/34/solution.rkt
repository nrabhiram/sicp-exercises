#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff
                   (* higher-terms x)))
              0
              coefficient-sequence))

;; Tests
;; 1 + 3x + 5x^3 + x^5 at x=2 => 1 + 6 + 40 + 32 = 79
(= (horner-eval 2 (list 1 3 0 5 0 1)) 79)
;; constant polynomial: 5 at any x
(= (horner-eval 10 (list 5)) 5)
;; x^2 + 1 at x=3 => 10
(= (horner-eval 3 (list 1 0 1)) 10)
;; empty coefficients
(= (horner-eval 5 nil) 0)
