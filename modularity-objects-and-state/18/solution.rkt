#lang sicp

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))
(define (contains-cycle? x)
  (let ((distinct-pairs '()))
    (define (new-pair? x pairs)
      (cond ((null? pairs) #t)
            ((eq? x (car pairs)) #f)
            (else
             (new-pair? x (cdr pairs)))))
    (define (register-pair x)
      (set! distinct-pairs
            (cons x distinct-pairs)))
    (define (traverse x)
      (cond ((null? x) #f)
            ((and (pair? x)
                  (not (new-pair? x distinct-pairs)))
             #t)
            ((and (pair? x) (new-pair? x distinct-pairs))
             (register-pair x)
             (traverse (cdr x)))))
    (traverse x)))

(contains-cycle? (list 'a 'b 'c))
(contains-cycle? (make-cycle (list 'a 'b 'c)))
