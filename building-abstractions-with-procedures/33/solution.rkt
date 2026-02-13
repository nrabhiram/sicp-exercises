#lang sicp

(define (filtered-accumulate filter combiner null-value term a next b)
  (define (get-filtered-term-value a)
    (if (filter a)
        (term a)
        null-value))

  (if (> a b)
      null-value
      (combiner (get-filtered-term-value a)
                (filtered-accumulate filter
                                     combiner
                                     null-value
                                     term
                                     (next a)
                                     next
                                     b))))

(define (prime? n)
  (define (even? x)
    (= (remainder x 2) 0))
  (define (square x) (* x x))
  (define (halve x) (/ x 2))
  (define (non-trivial-square-mod a)
    (define rem (remainder (square a) n))
    (define (non-trivial? a)
      (and (not (= a 1))
           (not (= a (- n 1)))
           (= rem 1)))

    (if (non-trivial? a)
        0
        rem))
  (define (expmod a exp)
    (cond ((= exp 0) 1)
          ((even? exp)
           (non-trivial-square-mod (expmod a (halve exp))))
          (else
            (remainder
             (* a (expmod a (- exp 1)))
             n))))
  (define (try)
    (= (expmod
        (+ (random (- n 1)) 1)
        (- n 1))
       1))
  (define (miller-rabin-test count)
    (cond ((= count 0) #t)
          ((try) (miller-rabin-test (- count 1)))
          (else #f)))

  (miller-rabin-test 5))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (square x) (* x x))

(define (incr x) (+ x 1))

(define (identity x) x)

(define (sum-squares a b)
  (define (prime-filter a)
    (and (> a 1)
         (prime? a)))
  (filtered-accumulate prime-filter + 0 square a incr b))

(define (product-rel-prime n)
  (define (rel-prime? a)
    (and (< a n)
         (= (gcd a n) 1)))

  (filtered-accumulate rel-prime? * 1 identity 1 incr n))

(sum-squares 1 10)
(product-rel-prime 10)
