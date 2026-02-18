#lang sicp

(define tolerance 0.00001)
(define dx 0.00001)

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

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx))
          (g x))
       dx)))

(define (newton-transform g)
  (lambda (x)
    (- x
       (/ (g x)
          ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point-of-transform g newton-transform guess))

(define (square x) (* x x))

(define (cube x) (* x x x))

(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c)))

(newtons-method (cubic 1 1 1) 1.0)
