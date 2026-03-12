#lang sicp

(define (make-interval a b) (cons a b))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))

(define (print-interval x)
  (display "(")
  (display (lower-bound x))
  (display ", ")
  (display (upper-bound x))
  (display ")"))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((x1 (lower-bound x))
        (x2 (upper-bound x))
        (y1 (lower-bound y))
        (y2 (upper-bound y)))
    (cond ((> x1 0)
           (cond ((> y1 0) (make-interval (* x1 y1)
                                          (* x2 y2)))
                 ((< y2 0) (make-interval (* x2 y1)
                                          (* x1 y2)))
                 (else (make-interval (* x2 y1)
                                      (* x2 y2)))))
          ((< x2 0)
           (cond ((> y1 0) (make-interval (* x1 y2)
                                          (* x2 y1)))
                 ((< y2 0) (make-interval (* x2 y2)
                                          (* x1 y1)))
                 (else (make-interval (* x1 y2)
                                      (* x1 y1)))))
          (else
           (cond ((> y1 0) (make-interval (* x1 y2)
                                          (* x2 y2)))
                 ((< y2 0) (make-interval (* x2 y1)
                                          (* x1 y1)))
                 (else (make-interval (min (* x1 y2) (* x2 y1))
                                      (max (* x1 y1) (* x2 y2)))))))))

(define (div-interval x y)
  (let ((spans-zero? (and (<= (lower-bound y) 0)
                          (>= (upper-bound y) 0))))
    (if spans-zero?
        (error "Division by an interval that spans zero")
        (mul-interval x
                      (make-interval (/ 1.0 (upper-bound y))
                                     (/ 1.0 (lower-bound y)))))))

(define (make-center-percent c p)
  (let ((l (- c
              (* (/ p 100.0) c)))
        (u (+ c
              (* (/ p 100.0) c))))
    (make-interval l u)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (let ((delta (/ (- (upper-bound i)
                     (lower-bound i))
                  2))
        (c (center i)))
    (* (/ delta c)
       100.0)))

(define (print-center-percent i)
  (display (center i))
  (display " ± ")
  (display (percent i))
  (display "%"))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one (add-interval (div-interval one r1)
                       (div-interval one r2)))))

(define (test-par r1 r2)
  (newline)
  (display "---")
  (newline)
  (display "Resistances to be connected in parallel: ")
  (print-center-percent r1)
  (display ", ")
  (print-center-percent r2)
  (newline)
  (display "Parallel resistance value (1st formula):")
  (print-center-percent (par1 r1 r2))
  (newline)
  (display "Parallel resistance value (2nd formula):")
  (print-center-percent (par2 r1 r2))
  (newline)
  (display "---")
  (newline))

(define (test-div a b)
  (newline)
  (display "---")
  (newline)
  (display "A: ")
  (print-center-percent a)
  (newline)
  (display "B: ")
  (print-center-percent b)
  (newline)
  (display "A/A: ")
  (print-center-percent (div-interval a a))
  (newline)
  (display "A/B: ")
  (print-center-percent (div-interval a b))
  (newline)
  (display "---")
  (newline))

; Test 1: Large tolerances — expect significant deviation
(test-par (make-center-percent 100 8)
          (make-center-percent 200 5))

; Test 2: Equal resistances with equal tolerances
(test-par (make-center-percent 100 5)
          (make-center-percent 100 5))

; Test 3: Very small tolerances — formulas should nearly agree
(test-par (make-center-percent 100 0.1)
          (make-center-percent 200 0.1))

; Test 4: Very large tolerances — deviation should be dramatic
(test-par (make-center-percent 100 20)
          (make-center-percent 200 15))

; Test 5: Unequal resistances, moderate tolerances
(test-par (make-center-percent 50 3)
          (make-center-percent 500 10))

; A/A and A/B tests — A/A should ideally be 1 ± 0%, but interval arithmetic overestimates
(test-div (make-center-percent 10 0.2)
          (make-center-percent 5 0.1))

(test-div (make-center-percent 100 5)
          (make-center-percent 200 3))

(test-div (make-center-percent 50 10)
          (make-center-percent 50 10))
