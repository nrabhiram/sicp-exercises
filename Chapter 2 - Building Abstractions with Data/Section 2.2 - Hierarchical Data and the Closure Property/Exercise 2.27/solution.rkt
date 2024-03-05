#lang sicp

(define (deep-reverse tree)
  (cond ((null? tree) nil)
        ((list? tree)
         (let ((el (car tree))
               (subtree (cdr tree)))
           (append (deep-reverse subtree)
                   (if (list? el)
                       (list (deep-reverse el))
                       (list el)))))))

(define (deep-reverse-2 tree)
  (define (test tree result)
    (cond ((null? tree) result)
          ((pair? tree)
           (let ((el (car tree))
                 (subtree (cdr tree)))
             (test subtree
                   (cons
                    (if (pair? el)
                        (deep-reverse-2 el)
                        el)
                    result))))))
  (test tree nil))

(define x (list (list 1 2) (list 3 4)))
(reverse x)
(deep-reverse-2 x)