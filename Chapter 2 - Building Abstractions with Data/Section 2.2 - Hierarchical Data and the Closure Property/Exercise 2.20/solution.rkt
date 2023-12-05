#lang sicp

(define (even? n)
  (= (remainder n 2) 0))

(define (same-parity-i x . y)
  (define (get-parity x)
    (if (even? x) 0 1))
  (define (iter l parity-list parity)
    (cond ((null? l) parity-list)
          ((= (get-parity (car l)) parity)
           (iter (cdr l)
                 (append parity-list
                         (list (car l)))
                 parity))
          (else
           (iter (cdr l)
                 parity-list
                 parity))))
  (let ((parity (get-parity x)))
    (iter y (list x) parity)))

(define (same-parity-r x . y)
  (define (get-parity x)
    (if (even? x) 0 1))
  (define (recur l)
    (cond ((null? l) nil)
          ((= (get-parity (car l))
              (get-parity x))
           (cons (car l)
                 (recur (cdr l))))
          (else (recur (cdr l)))))
  (cons x (recur y)))

(same-parity-i 1 2 3 4 5 6 7)
(same-parity-i 2 3 4 5 6 7)
(same-parity-r 1 2 3 4 5 6 7)
(same-parity-r 2 3 4 5 6 7)