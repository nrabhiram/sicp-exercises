#lang sicp

(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (make-center-percent c p)
  (let ((factor (/ p 100.0)))
    (make-interval (- c (* c factor))
                   (+ c (* c factor)))))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (let ((center (center i))
        (upper-bound (upper-bound i)))
    (* (/ (- upper-bound center) center) 100)))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define a (make-center-percent 10 0.5))
(define b (make-center-percent 10 0.4))
(define c (mul-interval a b))
(percent c)