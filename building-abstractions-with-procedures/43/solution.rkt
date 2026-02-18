#lang sicp

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (try n)
    (if (= n 1)
        f
        (compose f (try (- n 1)))))

  (try n))

(define (square x) (* x x))

((repeated square 2) 5)
