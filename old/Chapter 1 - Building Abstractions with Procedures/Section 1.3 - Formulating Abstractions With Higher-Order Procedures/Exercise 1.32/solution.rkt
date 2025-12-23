#lang sicp

(define (accumulate-recur combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate-recur combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (combiner (term a)
                        result))))
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

(define (inc x)
  (+ x 1))

(define (factorial-recur n)
  (product-recur identity 1 inc n))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(define (sum-int-recur n)
  (sum-recur identity 1 inc n))

(define (sum-int-iter n)
  (sum-iter identity 1 inc n))

(factorial-recur 5)
(factorial-iter 5)
(sum-int-recur 10)
(sum-int-iter 10)