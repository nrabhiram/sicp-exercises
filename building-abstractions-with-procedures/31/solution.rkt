#lang sicp

(define (product-recur term a next b)
  (if (> a b)
      1
      (* (term a) (product-recur term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))

  (iter a 1))

(define (even? x)
  (= (remainder x 2) 0))

(define (identity x) x)
(define (incr x) (+ x 1))

(define (pi-product prod n)
  (define (numerator-term n)
    (if (even? n)
        (+ n 2)
        (+ n 1)))
  (define (denominator-term n)
    (if (even? n)
        (+ n 1)
        (+ n 2)))
  (define (next a) (+ a 1))

  (/ (* 1.0 (prod numerator-term 1 next n))
     (prod denominator-term 1 next n)))

(define (factorial prod n)
  (prod identity 1 incr n))

(factorial product-recur 7)
(factorial product-iter 7)
(pi-product product-recur 100)
(* 4 (pi-product product-recur 100))
(pi-product product-iter 100)
(* 4 (pi-product product-iter 100))
