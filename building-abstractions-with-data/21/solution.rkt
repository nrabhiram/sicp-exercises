#lang sicp

(define (square x) (* x x))

(define (square-list items approach)
  (define (first items)
    (if (null? items)
        nil
        (cons (square (car items)) (first (cdr items)))))
  (define (second items)
    (map square items))

  (cond ((= approach 1) (first items))
        ((= approach 2) (second items))
        (else (error "approach is invalid"))))

(square-list (list 1 2 3 4) 1)
(square-list (list 1 2 3 4) 2)
