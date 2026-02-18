#lang sicp

(define tolerance 0.00001)

(define (fixed-point f initial-guess)
  (define (close-enough? a b)
    (let ((delta (- a b)))
      (< (abs delta) tolerance)))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? next guess)
          next
          (try next))))

  (try initial-guess))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (try n)
    (if (= n 1)
        f
        (compose f (try (- n 1)))))

  (try n))

(define (average x y)
  (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (nth-root x n)
  (fixed-point-of-transform
   (lambda (y) (/ x (expt y (- n 1))))
   (repeated average-damp (floor (log n 2)))
   1.0))

(nth-root 16 4)
(nth-root 32 5)
(nth-root 64 6)
(nth-root 128 7)
(nth-root 256 8)
