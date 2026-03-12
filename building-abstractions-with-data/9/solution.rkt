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
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (width-interval x)
  (/ (- (upper-bound x) (lower-bound x))
     2))

;; Two pairs of intervals with the same widths
(define a (make-interval 1 3))  ; width = 1
(define b (make-interval 2 4))  ; width = 1
(define c (make-interval 5 7))  ; width = 1
(define d (make-interval 6 8))  ; width = 1

(display "=== Test Intervals ===") (newline)
(display "a = ") (print-interval a) (newline)
(display "b = ") (print-interval b) (newline)
(display "c = ") (print-interval c) (newline)
(display "d = ") (print-interval d) (newline)
(newline)

;; Addition: width of sum = sum of widths (always)
(display "=== Addition ===") (newline)
(display "width(a+b) = ") (display (width-interval (add-interval a b))) (newline)
(display "width(a) + width(b) = ") (display (+ (width-interval a) (width-interval b))) (newline)
(display "width(c+d) = ") (display (width-interval (add-interval c d))) (newline)
(display "width(c) + width(d) = ") (display (+ (width-interval c) (width-interval d))) (newline)

;; Subtraction: width of difference = sum of widths (always)
(display "=== Subtraction ===") (newline)
(display "width(a-b) = ") (display (width-interval (sub-interval a b))) (newline)
(display "width(a) + width(b) = ") (display (+ (width-interval a) (width-interval b))) (newline)
(display "width(c-d) = ") (display (width-interval (sub-interval c d))) (newline)
(display "width(c) + width(d) = ") (display (+ (width-interval c) (width-interval d))) (newline)

;; Multiplication: same widths, different result widths
(display "=== Multiplication ===") (newline)
(display "width(a*b) = ") (display (width-interval (mul-interval a b))) (newline)
(display "width(c*d) = ") (display (width-interval (mul-interval c d))) (newline)

;; Division: same widths, different result widths
(display "=== Division ===") (newline)
(display "width(a/b) = ") (display (width-interval (div-interval a b))) (newline)
(display "width(c/d) = ") (display (width-interval (div-interval c d))) (newline)
