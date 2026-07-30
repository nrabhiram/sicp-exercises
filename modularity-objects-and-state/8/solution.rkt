#lang sicp

(define (construct-f)
  (let ((acc 0))
    (lambda (x)
      (set! acc (+ acc 1))
      (if (= acc 1)
          x
          0))))

(define f (construct-f))
(define f2 (construct-f))

(+ (f 0) (f 1))
(+ (f2 1) (f2 0))
