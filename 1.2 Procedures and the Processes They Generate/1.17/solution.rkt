#lang sicp

(define (* a b)
  (define (even? a)
    (= (remainder a 2) 0))
  (define (double a)
    (+ a a))
  (define (halve a)
    (/ a 2))
  (cond ((= b 0) 0)
        ((even? b) (double (* a (halve b))))
        (else (+ a (* a (- b 1))))))

(* 3 8)
(* 4 6)
(* 5 7)