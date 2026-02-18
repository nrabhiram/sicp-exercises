#lang sicp

(define tolerance 0.00001)

(define (iterative-improve close-enough? improve)
  (define (try guess)
    (let ((improved-guess (improve guess)))
      (if (close-enough? guess improved-guess)
          improved-guess
          (try improved-guess))))

  (lambda (guess) (try guess)))

(define (average x y)
  (/ (+ x y)
     2))

(define (square x) (* x x))

(define (sqrt x)
  ((iterative-improve
    (lambda (a b) (< (abs (- a b)) (* 0.00001 a)))
    (lambda (y) (average y (/ x y))))
    1.0))

(define (fixed-point f guess)
  ((iterative-improve
    (lambda (a b) (< (abs (- a b)) tolerance))
    f)
    guess))

(define (cbrt x)
  (fixed-point
   (lambda (y) (average y (/ x (square y))))
   1.0))

(sqrt 16)
(cbrt 64)
