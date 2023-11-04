#lang sicp

(define (filter-accumulate filter combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (filter a)
          (combiner (term a)
                    (filter-accumulate filter combiner null-value term (next a) next b))
          (filter-accumulate filter combiner null-value term (next a) next b))))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (smallest-divisor n)
  (define (square x)
    (* x x))
  (define (divides? divisor)
    (= (remainder n divisor)
       0))
  (define (find test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor) test-divisor)
          (else (find (+ test-divisor 1)))))
  (find 2))

(define (square x) (* x x))

(define (inc x)
  (+ x 1))

(define (gcd a b)
 (if (= b 0)
     a
     (gcd b (remainder a b))))

(define (identity x) x)

(define (sum-prime-squares a b)
  (filter-accumulate prime? + 0 square a inc b))

(define (prod-rel-prime n)
  (define (rel-prime? a)
    (= (gcd a n) 1))
  (filter-accumulate rel-prime? * 1 identity 1 inc n))

(sum-prime-squares 1 10)
(prod-rel-prime 10)

