#lang sicp

(define (fixed-point f guess)
  (define (close-enough? v1 v2 tolerance)
    (< (abs (- v1 v2))
       tolerance))
  (let ((new-guess (f guess))
        (tolerance 0.00001))
    (if (close-enough? new-guess
                       guess
                       tolerance)
        new-guess
        (fixed-point f new-guess))))

(define (fixed-point-of-transform f transform guess)
  (fixed-point (transform f) guess))

(define (deriv g)
  (lambda (x)
    (let ((dx (* 0.00001 x)))
      (/ (- (g (+ x dx))
            (g x))
         dx))))

(define (newton-transform g)
  (lambda (x)
    (- x
       (/ (g x)
          ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point-of-transform g newton-transform guess))

(define (cubic a b c)
  (define (cube x) (* x x x))
  (define (square x) (* x x))
  (lambda (x)
    (let ((cube-term (cube x))
          (square-term (* a (square x)))
          (x-term (* b x)))
      (+ cube-term square-term x-term c))))

(define a 1)
(define b 1)
(define c 1)

(newtons-method (cubic a b c) 1.0)