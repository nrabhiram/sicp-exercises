#lang sicp

(define (contains-cycle? x)
  (define (traverse pos1 pos2)
    (if (or (null? pos2) (null? (cdr pos2)))
        #f
        (let ((jump-pos1 (cdr pos1))
              (jump-pos2 (cddr pos2)))
          (if (eq? jump-pos1 jump-pos2)
              #t
              (traverse jump-pos1 jump-pos2)))))
  (traverse x x))
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(contains-cycle? (list 'a 'b 'c))
(contains-cycle? (make-cycle (list 'a 'b 'c)))
