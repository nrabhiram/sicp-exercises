#lang sicp

(define tolerance 0.00001)

(define (fixed-point f initial-guess)
  (define (close-enough? a b)
    (let ((delta (- a b)))
      (< (abs delta) tolerance)))
  (define (print-iteration guess iter final?)
    (newline)
    (display "guess value: ")
    (display guess)
    (display " | attempt: ")
    (display iter)
    (cond (final?
           (newline)
           (display "--- COMPUTATION ENDED ---")
           (newline))
          (else (display ""))))
  (define (try guess iteration)
    (let ((next (f guess)))
      (cond ((close-enough? next guess)
             (print-iteration next iteration #t)
             next)
            (else
             (print-iteration next iteration #f)
             (try next (+ 1 iteration))))))

  (try initial-guess 1))

(fixed-point
  (lambda (x)
    (/ (log 1000) (log x)))
  2)
(fixed-point
  (lambda (x)
    (/ (+ (/ (log 1000) (log x))
          x)
       2.0))
  2)
