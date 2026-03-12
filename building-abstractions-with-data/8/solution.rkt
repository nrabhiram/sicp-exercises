#lang sicp

(define (make-interval a b) (cons a b))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define a (make-interval 3 7))
(define b (make-interval 1 4))
(define result (sub-interval a b))
(lower-bound result)
(upper-bound result)
