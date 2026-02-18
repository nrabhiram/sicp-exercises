#lang sicp

(define dx 0.00001)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (try n)
    (if (= n 1)
        f
        (compose f (try (- n 1)))))

  (try n))

(define (smooth f)
  (lambda (x)
    (/ (+ (f (+ x dx))
          (f x)
          (f (- x dx)))
       3)))

(define (n-fold-smooth f n)
  ((repeated smooth n) f))
