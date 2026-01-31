#lang sicp

(define (fib-iter n)
  (define (incr-a a b p q)
    (+ (* b q)
       (* a q)
       (* a p)))
  (define (incr-b a b p q)
    (+ (* b p)
       (* a q)))
  (define (square x) (* x x))
  (define (transform-p p q)
    (+ (square p)
       (square q)))
  (define (transform-q p q)
    (+ (* 2 p q)
       (square q)))
  (define (even? x) (= (remainder x 2) 0))
  (define (iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
           (iter a
                 b
                 (transform-p p q)
                 (transform-q p q)
                 (/ count 2)))
          (else (iter (incr-a a b p q)
                      (incr-b a b p q)
                      p
                      q
                      (- count 1)))))

  (iter 1 0 0 1 n))

(fib-iter 4)
(fib-iter 30)
