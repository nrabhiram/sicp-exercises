#lang sicp

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d)
  (define (normalize x)
    (if (< x 0)
        -1
        1))

  (let ((g (abs (gcd n d)))
        (positive? (> (* n d) 0)))
    (if positive?
        (cons (/ (* (normalize n) n) g)
              (/ (* (normalize d) d) g))
        (cons (/ (- (abs n)) g)
              (/ (abs d) g)))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))

;; Tests

;; Sign normalization
(print-rat (make-rat 3 4))    ;  3/4
(print-rat (make-rat -3 4))   ; -3/4
(print-rat (make-rat 3 -4))   ; -3/4
(print-rat (make-rat -3 -4))  ;  3/4

;; GCD reduction
(print-rat (make-rat 6 8))    ;  3/4
(print-rat (make-rat -6 9))   ; -2/3
(print-rat (make-rat 10 -15)) ; -2/3

;; Arithmetic
(print-rat (add-rat (make-rat 1 3) (make-rat 1 6)))  ; 1/2
(print-rat (sub-rat (make-rat 3 4) (make-rat 1 4)))  ; 1/2
(print-rat (mul-rat (make-rat 2 3) (make-rat 3 4)))  ; 1/2
(print-rat (div-rat (make-rat 1 2) (make-rat 3 4)))  ; 2/3
