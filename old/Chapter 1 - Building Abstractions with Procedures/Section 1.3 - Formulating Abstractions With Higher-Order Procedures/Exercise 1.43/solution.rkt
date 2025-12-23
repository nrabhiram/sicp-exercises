#lang sicp

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (define (try g n)
    (if (= n 1)
        g
        (try (compose f g) (- n 1))))
  (try f n))

(define (square x)
  (* x x))

((repeated square 2) 5)