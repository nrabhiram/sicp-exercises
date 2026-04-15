#lang sicp

(define (split combiner splitter)
  (define (do p n)
    (if (= n 0)
        p
        (let ((smaller (do p (- n 1))))
          (combiner p (splitter smaller smaller)))))

  (lambda (painter n) (do painter n)))

(define right-split (split beside below))
(define up-split (split below beside))
