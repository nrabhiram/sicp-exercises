#lang sicp

(define (fast-prime? n)
  (define (expmod base exp m)
    (define (even? n)
      (= (remainder n 2) 0))
    (define (square n)
      (* n n))
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base
                                      (/ exp 2)
                                      m))
                      m))
          (else (remainder (* base
                              (expmod base
                                      (- exp 1)
                                      m))
                           m))))
  (define (fermat-test)
    (define (try-it a)
      (cond ((= a n) #t)
            ((= (expmod a n n) a)
             (try-it (+ a 1)))
            (else #f)))
    (try-it 2))
  (fermat-test))

(fast-prime? 561)
(fast-prime? 1105)
(fast-prime? 1729)
(fast-prime? 2465)
(fast-prime? 2821)
(fast-prime? 6601)