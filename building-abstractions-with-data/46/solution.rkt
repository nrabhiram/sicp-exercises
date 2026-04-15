#lang sicp

(define (make-vect x y) (list x y))
(define (x-cor-vect v) (car v))
(define (y-cor-vect v) (cadr v))

(define (add-vect v1 v2)
  (make-vect (+ (x-cor-vect v1) (x-cor-vect v2))
             (+ (y-cor-vect v1) (y-cor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (x-cor-vect v1) (x-cor-vect v2))
             (- (y-cor-vect v1) (y-cor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s (x-cor-vect v))
             (* s (y-cor-vect v))))

;; Tests
(define v1 (make-vect 1 2))
(define v2 (make-vect 3 5))

(x-cor-vect v1) ; 1
(y-cor-vect v1) ; 2

(add-vect v1 v2)   ; (4 7)
(sub-vect v2 v1)   ; (2 3)
(scale-vect 3 v1)  ; (3 6)
