#lang sicp

(define (make-vect x y) (list x y))
(define (x-cor-vect v) (car v))
(define (y-cor-vect v) (cadr v))

(define (make-frame-1 origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame-1 f) (car f))
(define (edge1-frame-1 f) (cadr f))
(define (edge2-frame-1 f) (caddr f))

(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame-2 f) (car f))
(define (edge1-frame-2 f) (cadr f))
(define (edge2-frame-2 f) (cddr f))

; Tests
(define origin (make-vect 0 0))
(define edge1 (make-vect 1 0))
(define edge2 (make-vect 0 1))

(define f1 (make-frame-1 origin edge1 edge2))
(display "List-based frame:")
(newline)
(display (origin-frame-1 f1))
(newline)
(display (edge1-frame-1 f1))
(newline)
(display (edge2-frame-1 f1))
(newline)

(newline)

(define f2 (make-frame-2 origin edge1 edge2))
(display "Cons-based frame:")
(newline)
(display (origin-frame-2 f2))
(newline)
(display (edge1-frame-2 f2))
(newline)
(display (edge2-frame-2 f2))
(newline)
