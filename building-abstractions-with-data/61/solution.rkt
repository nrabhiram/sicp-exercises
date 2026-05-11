#lang sicp

(define (adjoin-set x s)
  (cond ((null? s) (cons x s))
        ((= x (car s)) s)
        ((< x (car s)) (cons x s))
        (else (cons (car s) (adjoin-set x (cdr s))))))

; tests
(adjoin-set 3 '())          ; (3)
(adjoin-set 3 '(1 2 4 5))   ; (1 2 3 4 5)
(adjoin-set 1 '(2 3 4))     ; (1 2 3 4)
(adjoin-set 5 '(1 2 3))     ; (1 2 3 5)
(adjoin-set 3 '(1 2 3 4 5)) ; (1 2 3 4 5)
