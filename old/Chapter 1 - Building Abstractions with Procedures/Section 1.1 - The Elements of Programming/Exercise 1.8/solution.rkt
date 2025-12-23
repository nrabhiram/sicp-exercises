#lang sicp

(define (square x)
  (* x x))

(define (improve guess x)
  (/ (+ (/ x
           (square guess))
        (* 2 guess))
     3))

(define (good-enough? guess improved-guess)
  (< (/ (abs (- guess
                improved-guess))
        guess)
     0.00000000001))

(define (cbrt-iter x guess)
  (if (good-enough? guess (improve guess x))
      guess
      (cbrt-iter x (improve guess x))))

(define (cbrt radicand)
  (cbrt-iter radicand 1.0))

(cbrt 27)
(cbrt 64)
(cbrt 125)
(cbrt 216)