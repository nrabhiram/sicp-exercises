#lang sicp

(define (even? x)
  (= (remainder x 2) 0))

(define (same-parity . w)
  (define (get-parity x)
    (if (even? x)
        1
        2))
  (define (equal-parity? p x)
    (= p (get-parity x)))
  (define (try l r parity)
    (cond ((null? l) r)
          ((equal-parity? parity (car l))
           (try (cdr l)
                (append r (list (car l)))
                parity))
          (else
           (try (cdr l)
                r
                parity))))

  (let ((parity (get-parity (car w)))
        (l (cdr w))
        (r (list (car w))))
    (try l r parity)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)
