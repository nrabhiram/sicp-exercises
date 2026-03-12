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
       100)))

;; Tests
(define i1 (make-center-percent 100 10))
(display "make-center-percent 100 10: ") (print-interval i1) (newline)
;; expect (90, 110)

(display "center: ") (display (center i1)) (newline)
;; expect 100

(display "percent: ") (display (percent i1)) (newline)
;; expect 10

(define i2 (make-center-percent 50 5))
(display "make-center-percent 50 5: ") (print-interval i2) (newline)
;; expect (47.5, 52.5)

(display "center: ") (display (center i2)) (newline)
;; expect 50

(display "percent: ") (display (percent i2)) (newline)
;; expect 5
