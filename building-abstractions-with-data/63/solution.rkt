#lang sicp

(define (make-tree entry left right) (list entry left right))
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (adjoin x set)
  (cond ((null? set)
         (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin x (right-branch set))))))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1
                      (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                              (right-branch tree)
                              result-list)))))

  (copy-to-list tree '()))

(define tree-1 (adjoin 5 (adjoin 1 (adjoin 11 (adjoin 9 (adjoin 3 (adjoin 7 '())))))))
(define tree-2 (adjoin 11 (adjoin 9 (adjoin 5 (adjoin 7 (adjoin 1 (adjoin 3 '())))))))
(define tree-3 (adjoin 1 (adjoin 11 (adjoin 7 (adjoin 9 (adjoin 3 (adjoin 5 '())))))))

(display "=== tree->list-1 on tree-1 ===\n")
(tree->list-1 tree-1)
(display "\n=== tree->list-1 on tree-2 ===\n")
(tree->list-1 tree-2)
(display "\n=== tree->list-1 on tree-3 ===\n")
(tree->list-1 tree-3)

(display "\n=== tree->list-2 on tree-1 ===\n")
(tree->list-2 tree-1)
(display "\n=== tree->list-2 on tree-2 ===\n")
(tree->list-2 tree-2)
(display "\n=== tree->list-2 on tree-3 ===\n")
(tree->list-2 tree-3)
