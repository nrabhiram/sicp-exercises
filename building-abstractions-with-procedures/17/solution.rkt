#lang sicp

(define (fast-mult a b)
  (define (double x) (+ x x))
  (define (halve x) (/ x 2))
  (define (even? x)
    (= (remainder x 2) 0))

  (cond ((= b 0) 0)
        ((even? b) (double (fast-mult a (halve b))))
        (else (+ a (fast-mult a (- b 1))))))

(fast-mult 9 27)
