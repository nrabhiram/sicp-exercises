#lang sicp

(define (fixed-point f guess)
  (define (close-enough? v1 v2 tolerance)
    (< (abs (- v1 v2))
       tolerance))
  (let ((new-guess (f guess))
        (tolerance 0.00001))
    (if (close-enough? new-guess
                       guess
                       tolerance)
        new-guess
        (fixed-point f new-guess))))

(define (fixed-point-of-transform f transform guess)
  (fixed-point (transform f) guess))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (define (try g n)
    (if (= n 1)
        g
        (try (compose f g) (- n 1))))
  (try f n))

(define (average-damp f)
  (lambda (x)
    (/ (+ x (f x))
       2)))

(define (nth-root x n)
  (fixed-point-of-transform
   (lambda (y)
     (/ x (expt y (- n 1))))
   (repeated average-damp (floor (log n 2)))
   1.0))

(nth-root 16 4)
(nth-root 256 8)