#lang sicp

(define (fast-mult a b)
  (define (double x) (+ x x))
  (define (halve x) (/ x 2))
  (define (even? x)
    (= (remainder x 2) 0))
  (define (iter a b res)
    (cond ((= b 0) res)
          ((even? b) (iter (double a) (halve b) res))
          (else (iter a (- b 1) (+ res a)))))

  (iter a b 0))

(fast-mult 9 27)
