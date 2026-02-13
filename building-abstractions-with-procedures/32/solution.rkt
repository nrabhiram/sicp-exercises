#lang sicp

(define (accumulate-recur combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate-recur combiner
                                  null-value
                                  term
                                  (next a)
                                  next b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))

  (iter a null-value))

(define (sum-recur term a next b)
  (accumulate-recur + 0 term a next b))
(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

(define (product-recur term a next b)
  (accumulate-recur * 1 term a next b))
(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

(define (identity x) x)
(define (incr x) (+ x 1))

(define (sum-integers sum n)
  (sum identity 1 incr n))

(define (factorial prod n)
  (prod identity 1 incr n))

(sum-integers sum-recur 10)
(sum-integers sum-iter 10)
(factorial product-recur 7)
(factorial product-iter 7)
