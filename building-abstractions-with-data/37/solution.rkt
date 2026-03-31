#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (r) (dot-product r v)) m))

(define (transpose mat)
  (accumulate-n cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map
     (lambda (row)
       (map (lambda (col) (dot-product row col)) cols))
     m)))

;; tests

(dot-product (list 1 2 3) (list 4 5 6)) ; 32

(define m (list (list 1 2 3 4)
                (list 4 5 6 6)
                (list 6 7 8 9)))

(matrix-*-vector m (list 1 0 0 0)) ; (1 4 6)
(matrix-*-vector m (list 1 1 1 1)) ; (10 21 30)

(transpose m) ; ((1 4 6) (2 5 7) (3 6 8) (4 6 9))

(define a (list (list 1 2 3)
                (list 6 7 8)))

(define b (list (list 1 2)
                (list 4 3)
                (list 6 7)))

(define c (list (list 1 2 4)
                (list 4 3 5)
                (list 6 7 9)))

(matrix-*-matrix a b) ; ((27 29) (82 89))
(matrix-*-matrix a c) ; ((27 29 41) (82 89 131))
