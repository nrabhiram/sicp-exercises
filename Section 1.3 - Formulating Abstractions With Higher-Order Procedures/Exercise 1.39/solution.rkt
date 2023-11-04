#lang sicp

(define (cont-frac n d k)
  (define (compute-frac num den acc)
    (if (= acc 0)
        (/ num den 1.0)
        (compute-frac (n acc) (+ (d acc) (/ num den)) (- acc 1))))
  (compute-frac 0 1 k))

(define (tan-cf x k)
  (cont-frac (lambda (i)
               (if (= i 1)
                   x
                   ((lambda (x) (- (* x x))) x)))
             (lambda (i)
               (- (* 2 i) 1))
             k))

(tan-cf 1 10)