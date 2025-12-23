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
      (= (expmod a n n) a))
    (try-it (+ (random (- n 1))
               1)))
  (fermat-test))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n)
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

(search-for-primes 1000000 1050000)