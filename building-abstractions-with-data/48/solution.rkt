#lang sicp

(define (make-vect x y) (list x y))
(define (x-cor-vect v) (car v))
(define (y-cor-vect v) (cadr v))

(define (make-segment start end) (list start end))
(define (start-segment s) (car s))
(define (end-segment s) (cadr s))

;; Tests
(define v1 (make-vect 1 2))
(define v2 (make-vect 3 4))
(define seg (make-segment v1 v2))

(start-segment seg)
(end-segment seg)
