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
  (let ((spans-zero? (and (<= (lower-bound y) 0)
                          (>= (upper-bound y) 0))))
    (if spans-zero?
        (error "Division by an interval that spans zero")
        (mul-interval x
                      (make-interval (/ 1.0 (upper-bound y))
                                     (/ 1.0 (lower-bound y)))))))

(define (width-interval x)
  (/ (- (upper-bound x) (lower-bound x))
     2))

(define a (make-interval 1 3))  ; width = 1
(define b (make-interval 2 4))  ; width = 1

(display "=== Test Intervals ===") (newline)
(display "a = ") (print-interval a) (newline)
(display "b = ") (print-interval b) (newline)
(newline)

;; Normal division should work
(display "=== Division by zero-spanning intervals ===") (newline)
(display "Normal: (1,3) / (2,4) = ") (print-interval (div-interval a b)) (newline)

;; These should all error — uncomment one at a time to test:

;; Interval spans zero: (-2, 3)
(div-interval a (make-interval -2 3))

;; Lower bound is zero: (0, 5)
;; (div-interval a (make-interval 0 5))

;; Upper bound is zero: (-5, 0)
;; (div-interval a (make-interval -5 0))

;; Both bounds are zero: (0, 0)
;; (div-interval a (make-interval 0 0))
