#lang sicp

(define (fast-prime? n)
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

(fast-prime? 1009)
(fast-prime? 10007)
(fast-prime? 100003)
(fast-prime? 1000003)

(fast-prime? 561)
(fast-prime? 1105)
(fast-prime? 1729)
(fast-prime? 2465)
(fast-prime? 2821)
(fast-prime? 6601)
