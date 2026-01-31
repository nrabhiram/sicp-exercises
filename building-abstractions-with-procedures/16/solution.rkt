#lang sicp

(define (fast-exp b n)
  (define (square x) (* x x))
  (define (halve x) (/ x 2))
  (define (even? x)
    (= (remainder x 2) 0))
  (define (iter a b n)
    (cond ((= n 0) a)
          ((even? n) (iter a (square b) (halve n)))
          (else (iter (* a b) b (- n 1)))))

  (iter 1 b n))

(fast-exp 2 4)
(fast-exp 9 7)
