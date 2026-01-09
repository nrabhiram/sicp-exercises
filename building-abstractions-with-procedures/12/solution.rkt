#lang sicp

(define (pascal-triangle row col)
  (cond ((= col 1) 1)
        ((= col row) 1)
        (else (+ (pascal-triangle (- row 1) (- col 1))
                 (pascal-triangle (- row 1) col)))))

(pascal-triangle 3 2)
(pascal-triangle 4 1)
(pascal-triangle 4 2)
(pascal-triangle 4 3)
(pascal-triangle 4 4)
(pascal-triangle 5 2)
(pascal-triangle 5 3)
