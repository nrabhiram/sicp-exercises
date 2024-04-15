#lang sicp

(define (iterative-improve good-enough? improve)
  (define (try guess)
    (if (good-enough? guess)
        guess
        (try (improve guess))))
  (lambda (guess) (try guess)))

(define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess)
               x))
       0.001))
  (define (improve guess)
    (* (average guess
                (/ x guess))
       1.0))
  ((iterative-improve good-enough? improve) 1.0))

(define (average-damp f)
  (lambda (x)
    (average x (f x))))

(define (fixed-point f guess)
  (define tolerance 0.00001)
  (define (close-enough? guess)
    (< (abs (- guess
               (f guess)))
       tolerance))
  ((iterative-improve close-enough? f) guess))

(define (cbrt x)
  (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))

(sqrt 9)
(cbrt 27)