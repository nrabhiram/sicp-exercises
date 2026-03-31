#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate +
              0
              (map
               (lambda (el)
                 (if (not (pair? el))
                     1
                     (count-leaves el)))
               t)))

(display (count-leaves (list 1 2 3 4)))          ; 4
(newline)
(display (count-leaves (list (list 1 2) 3 4)))   ; 4
(newline)
(display (count-leaves (list (list 1 (list 2 3)) 4))) ; 4
(newline)
(display (count-leaves (list 1)))                 ; 1
(newline)
