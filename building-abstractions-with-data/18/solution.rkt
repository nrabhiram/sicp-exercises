#lang sicp

(define (reverse li)
  (define (try li r)
    (if (null? li)
        r
        (try (cdr li) (cons (car li) r))))

  (try li nil))

(define (append li1 li2)
  (if (null? li1)
      li2
      (cons (car li1) (append (cdr li1) li2))))

(define (reverse-recur li)
  (if (null? li)
      nil
      (append (reverse-recur (cdr li)) (list (car li)))))

(reverse (list 1 4 9 16 25))
(reverse-recur (list 1 4 9 16 25))
