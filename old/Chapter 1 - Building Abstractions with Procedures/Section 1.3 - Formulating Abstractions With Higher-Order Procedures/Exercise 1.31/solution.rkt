#lang sicp

(define (product-recur term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-recur term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(define (identity x) x)

(define (inc x)
  (+ x 1))

(define (factorial-recur n)
  (product-recur identity 1 inc n))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(define (pi-product-recur n)
  (define (even? x)
    (= (remainder x 2) 0))
  (define (num-term x)
    (if (even? x)
        (+ x 2)
        (+ x 1)))
  (define (den-term x)
    (if (even? x)
        (+ x 1)
        (+ x 2)))
  (/ (product-recur num-term 1 inc n)
     (product-recur den-term 1 inc n)
     1.0))

(define (pi-product-iter n)
  (define (even? x)
    (= (remainder x 2) 0))
  (define (num-term x)
    (if (even? x)
        (+ x 2)
        (+ x 1)))
  (define (den-term x)
    (if (even? x)
        (+ x 1)
        (+ x 2)))
  (/ (product-iter num-term 1 inc n)
     (product-iter den-term 1 inc n)
     1.0))

(factorial-recur 5)
(factorial-iter 5)
(pi-product-recur 1000)
(pi-product-iter 1000)