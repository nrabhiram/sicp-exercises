#lang sicp

(define (* a b)
  (define (even? a)
    (= (remainder a 2) 0))
  (define (double a)
    (+ a a))
  (define (halve a)
    (/ a 2))
  (define (mul-iter a b c)
    (cond ((= b 0) c)
          ((even? b) (mul-iter (double a) (halve b) c))
          (else (mul-iter a (- b 1) (+ c a)))))
  (mul-iter a b 0))

(* 5 4)
(* 6 7)
(* 10 17)