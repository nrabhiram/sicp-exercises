#lang sicp

(define (reverse-i list)
  (define (iter list reversed-list)
    (if (null? list)
        reversed-list
        (iter (cdr list)
              (cons (car list)
                    reversed-list))))
  (iter list nil))

(define (reverse-r l)
  (if (null? l)
      nil
      (append (reverse-r (cdr l))
              (list (car l)))))

(reverse-i (list 1 4 9 16 25))
(reverse-r (list 1 4 9 16 25))
