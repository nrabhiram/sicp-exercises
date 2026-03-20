#lang sicp

(define (deep-reverse tree)
  (define (try li r)
    (cond ((null? li) r)
          ((pair? (car li))
           (try (cdr li)
                (cons (try (car li) nil)
                      r)))
          (else
           (try (cdr li)
                (cons (car li) r)))))

  (try tree nil))

(define x (list (list 1 2) (list 3 4)))

(deep-reverse x)
