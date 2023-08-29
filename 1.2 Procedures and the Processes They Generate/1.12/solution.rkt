#lang sicp

(define (pascal row index)
  (cond ((or (<= row 0) (or (> index row) (< index 1))) 0)
        ((or (= index 1) (= index row)) 1)
        (else (+ (pascal (- row 1)
                         (- index 1))
                 (pascal (- row 1)
                         index)))))

(pascal 4 2)