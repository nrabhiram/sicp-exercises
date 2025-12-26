#lang sicp

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (good-enough? guess prev-guess)
  (< (abs (/ (- guess prev-guess) prev-guess)) 0.00000000001))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (cube-root-iter guess x)
  (if (good-enough? (improve guess x) guess)
      guess
      (cube-root-iter (improve guess x) x)))

(define (cube-root x) (cube-root-iter 1.0 x))

(cube-root 27)
(cube-root 8)
(define test-cube-root (cube-root 12345))
(cube test-cube-root)
