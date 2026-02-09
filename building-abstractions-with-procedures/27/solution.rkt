#lang sicp

(define (fast-prime? n)
  (define (even? x)
    (= (remainder x 2) 0))
  (define (square x) (* x x))
  (define (halve x) (/ x 2))
  (define (expmod a exp n)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder
            (square (expmod a (halve exp) n))
            n))
          (else
            (remainder
             (* a (expmod a (- exp 1) n))
             n))))
  (define (try a)
    (= (expmod a n n) a))
  (define (fermat-test a)
    (cond ((and (< a n) (try a))
           (fermat-test (+ a 1)))
          ((= a n) #t)
          (else #f)))

  (fermat-test 1))

(fast-prime? 561)
(fast-prime? 1105)
(fast-prime? 1729)
(fast-prime? 2465)
(fast-prime? 2821)
(fast-prime? 6601)
