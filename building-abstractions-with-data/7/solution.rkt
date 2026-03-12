#lang sicp

(define (make-interval a b) (cons a b))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))

(define i (make-interval 2 9))
(lower-bound i)
(upper-bound i)
