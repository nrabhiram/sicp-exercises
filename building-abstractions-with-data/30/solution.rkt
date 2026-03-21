#lang sicp

(define (square x) (* x x))

(define (square-tree type)
  (define (without-map tree)
    (cond ((null? tree) nil)
          ((not (pair? tree)) (square tree))
          (else (cons (without-map (car tree))
                      (without-map (cdr tree))))))
  (define (with-map tree)
    (map (lambda (subtree)
           (if (pair? subtree)
               (with-map subtree)
               (square subtree)))
         tree))

  (if (= type 1)
      without-map
      with-map))

(define test-list
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))

((square-tree 1) test-list)
((square-tree 2) test-list)
