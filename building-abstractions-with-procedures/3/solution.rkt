#lang sicp

(define (square x) (* x x))

(define (sum-squares x y)
  (+ (square x)
     (square y)))

(define (<= a b)
  (or (< a b) (= a b)))

(define (smallest a b c)
  (and (<= a b) (<= a c)))

(define (largest-squares-sum a b c)
  (cond ((smallest a b c) (sum-squares b c))
        ((smallest b a c) (sum-squares a c))
        (else (sum-squares a b))))

(largest-squares-sum 1 2 3)
(largest-squares-sum 6 4 5)
(largest-squares-sum 2 7 1)
(largest-squares-sum 3 3 1)
(largest-squares-sum 1 4 4)
(largest-squares-sum 5 4 5)
(largest-squares-sum 1 1 3)
(largest-squares-sum 2 4 2)
(largest-squares-sum 4 3 3)
(largest-squares-sum 2 2 2)
