#lang sicp

(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else
         (let ((x1 (car s1))
               (x2 (car s2)))
           (cond ((= x1 x2)
                  (cons x1
                        (union-set (cdr s1) (cdr s2))))
                 ((< x1 x2)
                  (cons x1
                        (union-set (cdr s1) s2)))
                 (else
                  (cons x2
                        (union-set s1 (cdr s2)))))))))

;; Tests
(display (union-set '(1 2 3 4) '(3 4 5 6)))  (newline) ; (1 2 3 4 5 6)
(display (union-set '() '(1 2 3)))           (newline) ; (1 2 3)
(display (union-set '(1 2 3) '()))           (newline) ; (1 2 3)
(display (union-set '() '()))                (newline) ; ()
(display (union-set '(1 2 3) '(4 5 6)))      (newline) ; (1 2 3 4 5 6) - disjoint
(display (union-set '(1 2 3) '(1 2 3)))      (newline) ; (1 2 3) - identical
(display (union-set '(1) '(2)))              (newline) ; (1 2)
