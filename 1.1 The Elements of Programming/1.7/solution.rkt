#lang sicp

(define (improve guess x)
  (/ (+ guess
        (/ x guess))
     2))

(define (good-enough? guess improved-guess)
  (< (/ (abs (- guess improved-guess))
        guess)
     0.00000000001))

(define (sqrt-iter x guess)
  (if (good-enough? guess (improve guess x))
      guess
      (sqrt-iter x (improve guess x))))

(define (sqrt radicand)
  (sqrt-iter radicand 1.0))

(sqrt 4)
(sqrt 9)
(sqrt 16)
(sqrt 25)