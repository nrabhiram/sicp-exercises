#lang sicp

(define pi 3.14)

(define (cont-frac n d k)
  (define (calc res i)
    (let ((num (n i))
          (den (d i)))
      (if (< i 1)
          res
          (let ((term
                 (/ num
                    (+ den res))))
            (calc term (- i 1))))))

  (calc 0 k))

(define (square x) (* x x))

(define (tan-cf x k)
  (define (n i)
    (cond ((= i 1) x)
          (else (- (square x)))))
  (define (d i)
    (- (* i 2.0) 1))
  (cont-frac n d k))

(tan-cf (/ pi 4) 30)
(tan-cf 1 24)
