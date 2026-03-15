#lang sicp

(define (square x) (* x x))

(define (square-list items approach)
  (define (first things answer)
    (if (null? things)
        answer
        (first (cdr things)
              (cons (square (car things))
                    answer))))
  (define (second things answer)
    (if (null? things)
        answer
        (second (cdr things)
              (cons answer
                    (square (car things))))))

  (cond ((= approach 1) (first items nil))
        ((= approach 2) (second items nil))
        (else (error "approach is invalid"))))

(square-list (list 1 2 3 4) 1)
(square-list (list 1 2 3 4) 2)
