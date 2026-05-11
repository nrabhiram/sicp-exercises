#lang sicp

(define (make-record key data) (list key data))
(define (key record) (car record))
(define (data record) (cdr record))

(define (make-tree entry left right) (list entry left right))
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (lookup given-key records)
  (cond ((null? records) #f)
        ((< given-key (key (entry records)))
         (lookup given-key (left-branch records)))
        ((> given-key (key (entry records)))
         (lookup given-key (right-branch records)))
        ((= given-key (key (entry records))) (entry records))))

(define (adjoin x set)
  (cond ((null? set)
         (make-tree x '() '()))
        ((= (key x) (key (entry set))) set)
        ((< (key x) (key (entry set)))
         (make-tree (entry set)
                    (adjoin x (left-branch set))
                    (right-branch set)))
        ((> (key x) (key (entry set)))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin x (right-branch set))))))

(define tree
  (adjoin (make-record 5 "five")
          (adjoin (make-record 3 "three")
                  (adjoin (make-record 8 "eight")
                          (adjoin (make-record 1 "one")
                                  (adjoin (make-record 4 "four")
                                          (adjoin (make-record 7 "seven")
                                                  (adjoin (make-record 10 "ten") '()))))))))

tree

(lookup 3 tree)
(lookup 7 tree)
(lookup 6 tree)
