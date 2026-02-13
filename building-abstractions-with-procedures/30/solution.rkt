#lang sicp

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(define (identity x) x)
(define (cube x) (* x x x))

(define (incr x) (+ x 1))

(define (sum-integers a b)
  (sum identity a incr b))
(define (sum-cubes a b)
  (sum cube a incr b))

(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x) (+ x 4))

  (sum pi-term a pi-next b))

(sum-integers 1 10)
(sum-cubes 1 10)
(* 8 (pi-sum 1 1000))
