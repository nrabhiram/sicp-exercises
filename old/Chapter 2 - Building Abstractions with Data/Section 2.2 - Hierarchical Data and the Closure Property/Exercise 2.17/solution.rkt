#lang sicp

(define (last-pair list)
  (define (null-cdr list)
    (if (null? list)
        nil
        (cdr list)))
  (define (iter list sublist)
    (if (null? sublist)
        list
        (iter sublist (null-cdr sublist))))
  (iter list (null-cdr list)))

(last-pair (list 23 72 149 34))