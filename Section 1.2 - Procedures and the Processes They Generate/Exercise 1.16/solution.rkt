#lang sicp

(define (expt-iter base exponent)
  (define (square a)
    (* a a))
  (define (even? n)
    (= (remainder n 2) 0))
  (define (iter b n a)
    (cond ((= n 0) a)
          ((even? n) (iter (square b)
                           (/ n 2)
                           a))
          (else (iter b
                      (- n 1)
                      (* a b)))))
  (iter base exponent 1))

(expt-iter 2 3)
(expt-iter 2 4)
(expt-iter 2 5)