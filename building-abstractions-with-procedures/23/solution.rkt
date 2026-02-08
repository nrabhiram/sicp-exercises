#lang sicp

(define (prime? n)
  (define (divides? a)
    (= (remainder n a) 0))
  (define (square a) (* a a))
  (define (next a)
    (cond ((= a 2) 3)
          (else (+ a 2))))
  (define (find-divisor a)
    (cond ((> (square a) n) n)
          ((divides? a) a)
          (else (find-divisor (next a)))))
  (define (smallest-divisor) (find-divisor 2))
  (define (is-prime?) (= (smallest-divisor) n))

  (is-prime?))

(define (timed-prime-test n)
  (define (start-prime-test start-time)
    (if (prime? n)
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
(search-for-primes 1000000 1100000)
