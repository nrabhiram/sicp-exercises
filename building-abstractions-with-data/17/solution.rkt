#lang sicp

(define (last-pair li)
  (cond ((null? li) (error "List provided is invalid. Please use a non-empty list."))
        ((null? (cdr li)) li)
        (else (last-pair (cdr li)))))

(last-pair (list 23 72 149 34))
; (last-pair nil)
