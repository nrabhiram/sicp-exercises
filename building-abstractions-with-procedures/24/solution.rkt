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
  (define (fermat-test)
    (try (+ 1 (random (- n 1)))))

  (fermat-test))

(define (timed-prime-test n)
  (define (start-prime-test start-time)
    (if (fast-prime? n)
        (report-prime (- (runtime) start-time))
        (display " *** —")))
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

  (newline)
  (display n)
  (start-prime-test (runtime)))

(define (search-for-primes start end)
  (define (even? a) (= (remainder a 2) 0))

  (cond ((even? start)
         (search-for-primes (+ start 1) end))
        ((<= start end)
         (timed-prime-test start)
         (search-for-primes (+ start 2) end))
        (else
         (newline)
         (display "--- computation finished ---"))))

;(search-for-primes 1000 1100)
;(search-for-primes 10000 11000)
;(search-for-primes 100000 110000)
;(search-for-primes 1000000 1100000)
(search-for-primes 10000000 11000000)
