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

(define (smooth f)
  (lambda (x)
    (define dx (* x 0.00001))
    (let ((a (- x dx))
          (b (+ x dx)))
      (/ (+ (f a) (f x) (f b)) 3))))

(define (smooth-nth f n)
  (repeated f n))