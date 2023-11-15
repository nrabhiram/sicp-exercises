#lang sicp

(define (cons x y)
  (lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))
(define (cdr z)
  (z (lambda (p q) q)))

(define pair (cons 1 2))
(display (car pair))
(newline)
(display (cdr pair))