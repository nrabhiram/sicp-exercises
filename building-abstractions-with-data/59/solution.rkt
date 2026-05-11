#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (union-set s1 s2)
  (cond ((null? s2) s1)
        ((null? s1) s2)
        ((not (element-of-set? (car s1) s2))
         (cons (car s1)
               (union-set (cdr s1) s2)))
        (else (union-set (cdr s1) s2))))

(union-set '(1 2 3) '(4 5 6))       ; (1 2 3 4 5 6)
(union-set '(1 2 3) '(2 3 4))       ; (1 2 3 4)
(union-set '() '(1 2 3))            ; (1 2 3)
(union-set '(1 2 3) '())            ; (1 2 3)
(union-set '() '())                 ; ()
(union-set '(1 2 3) '(1 2 3))       ; (1 2 3)
