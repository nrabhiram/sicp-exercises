#lang sicp

(define (sum f a next b)
  (if (> a b)
      0
      (+ (f a) (sum f (next a) next b))))

(define (cube x) (* x x x))

(define (integral f a b n)
  (define h (/ (- b a) n))
  (define (even? x)
    (= (remainder x 2) 0))
  (define (next a) (+ a h))
  (define (term x)
    (define k (/ (- x a) h))
    (define y (f x))
    (cond ((= k 0) y)
          ((= k n) y)
          ((even? k) (* 2 y))
          (else (* 4 y))))

  (* (/ h 3.0)
     (sum term a next b)))

(integral cube 0 1 100)
(integral cube 0 1 1000)
