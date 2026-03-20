#lang sicp

(define (make-mobile left right)
  (list left right))
(define (left-branch m)
  (car m))
(define (right-branch m)
  (car (cdr m)))
(define (mobile? m)
  (and (pair? m)
       (branch? (left-branch m))
       (branch? (right-branch m))))

(define (make-branch length structure)
  (list length structure))
(define (branch-length b)
  (car b))
(define (branch-structure b)
  (car (cdr b)))
(define (branch? b)
  (and (pair? b)
       (not (pair? (branch-length b)))))

(define (total-weight m)
  (cond ((mobile? m)
         (+ (total-weight (left-branch m))
            (total-weight (right-branch m))))
        ((and (branch? m)
              (mobile? (branch-structure m)))
         (total-weight (branch-structure m)))
        (else (branch-structure m))))

(define (torque b)
  (* (branch-length b)
     (total-weight b)))

(define (balanced? m)
  (cond ((mobile? m)
         (and (= (torque (left-branch m))
                 (torque (right-branch m)))
              (balanced? (left-branch m))
              (balanced? (right-branch m))))
        ((and (branch? m)
              (mobile? (branch-structure m)))
         (balanced? (branch-structure m)))
        (else #t)))

;; simple mobile: two weights
(define m1 (make-mobile (make-branch 2 3)
                        (make-branch 3 2)))

;; nested mobile: right branch holds a sub-mobile
(define m2 (make-mobile (make-branch 4 6)
                        (make-branch 2 (make-mobile (make-branch 1 4)
                                                    (make-branch 2 2)))))

;; unbalanced mobile
(define m3 (make-mobile (make-branch 3 5)
                        (make-branch 2 7)))

;; total-weight tests
(display "total-weight m1: ") (display (total-weight m1)) (newline)  ; 5
(display "total-weight m2: ") (display (total-weight m2)) (newline)  ; 12
(display "total-weight m3: ") (display (total-weight m3)) (newline)  ; 12

;; balanced? tests
(display "balanced? m1: ") (display (balanced? m1)) (newline)  ; #t (2*3 = 3*2)
(display "balanced? m2: ") (display (balanced? m2)) (newline)  ; #t (4*6 = 2*6, 1*4 = 2*2)
(display "balanced? m3: ") (display (balanced? m3)) (newline)  ; #f (3*5 != 2*7)
