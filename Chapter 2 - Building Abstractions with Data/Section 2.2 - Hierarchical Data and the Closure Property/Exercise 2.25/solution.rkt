#lang sicp

(define tree-1 (list 1 3 (list 5 7) 9))
(define tree-2 (list (list 7)))
(define tree-3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

tree-1
tree-2
tree-3

(car (cdr (car (cdr (cdr tree-1)))))
(car (car tree-2))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr tree-3))))))))))))