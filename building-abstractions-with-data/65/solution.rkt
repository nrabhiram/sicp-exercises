#lang sicp

(define (make-tree entry left right) (list entry left right))
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                              (right-branch tree)
                              result-list)))))

  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
               (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

(define (union-set s1 s2)
  (define (find-union ol1 ol2)
    (cond ((null? ol1) ol2)
          ((null? ol2) ol1)
          (else
           (let ((x1 (car ol1))
                 (x2 (car ol2)))
             (cond ((= x1 x2)
                    (cons x1
                          (find-union (cdr ol1) (cdr ol2))))
                   ((< x1 x2)
                    (cons x1
                          (find-union (cdr ol1) ol2)))
                   (else
                    (cons x2
                          (find-union ol1 (cdr ol2)))))))))

  (let ((ol1 (tree->list s1))
        (ol2 (tree->list s2)))
    (list->tree (find-union ol1 ol2))))

(define (intersection-set s1 s2)
  (define (find-intersection ol1 ol2)
    (cond ((or (null? ol1) (null? ol2))
           '())
          ((= (car ol1) (car ol2))
           (cons (car ol1)
                 (find-intersection (cdr ol1) (cdr ol2))))
          ((< (car ol1) (car ol2))
           (find-intersection (cdr ol1) ol2))
          ((> (car ol1) (car ol2))
           (find-intersection ol1 (cdr ol2)))))

  (let ((ol1 (tree->list s1))
        (ol2 (tree->list s2)))
    (list->tree (find-intersection ol1 ol2))))

(define t1 (list->tree '(1 3 5 7 9)))
(define t2 (list->tree '(2 3 5 8 9)))

(union-set t1 t2)
(intersection-set t1 t2)
