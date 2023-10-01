#lang sicp

(define (prime? n)
  (= (smallest-divisor n) n))

(define (smallest-divisor n)
  (define (square x)
    (* x x))
  (define (divides? divisor)
    (= (remainder n divisor)
       0))
  (define (next n)
    (if (= n 2)
        3
        (+ n 2)))
  (define (find test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor) test-divisor)
          (else (find (next test-divisor)))))
  (find 2))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))
      (display " *** -")))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start-point end-point)
  (cond ((even? start-point)
         (search-for-primes (+ start-point 1) end-point))
        ((<= start-point end-point)
         (timed-prime-test start-point)
         (search-for-primes (+ start-point 2) end-point))
        (else
         (newline)
         (display "--- computation finished ---"))))

(search-for-primes 1000000 1100000)