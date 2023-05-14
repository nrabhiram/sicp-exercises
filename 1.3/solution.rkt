#lang sicp

(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (sum-of-larger-squares x y z)
  (cond ((and (not (< y x)) (not (< z x))) (sum-of-squares y z))
        ((and (not (< x y)) (not (< z y))) (sum-of-squares x z))
        ((and (not (< x z)) (not (< y z))) (sum-of-squares x y))))

(sum-of-larger-squares 3 4 2)
(sum-of-larger-squares 4 3 2)
(sum-of-larger-squares 2 3 4)
(sum-of-larger-squares 5 6 5)
