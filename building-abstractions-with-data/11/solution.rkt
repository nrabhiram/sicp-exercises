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

;; old brute-force version of mul-interval for comparison
(define (mul-interval-old x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (print-result label a b passed)
  (display label)
  (display ": ")
  (display (if passed "PASS" "FAIL"))
  (display " expected ")
  (print-interval b)
  (display " got ")
  (print-interval a)
  (newline))

(define (assert-equal a b label)
  (print-result label a b
                (and (= (lower-bound a) (lower-bound b))
                     (= (upper-bound a) (upper-bound b)))))

;; test intervals
(define pos (make-interval 2 4))    ; both positive
(define neg (make-interval -5 -3))  ; both negative
(define span (make-interval -2 3))  ; spans zero

;; all 9 cases
(assert-equal (mul-interval pos pos)
              (mul-interval-old pos pos)
              "pos * pos")
(assert-equal (mul-interval pos neg)
              (mul-interval-old pos neg)
              "pos * neg")
(assert-equal (mul-interval pos span)
              (mul-interval-old pos span)
              "pos * span")
(assert-equal (mul-interval neg pos)
              (mul-interval-old neg pos)
              "neg * pos")
(assert-equal (mul-interval neg neg)
              (mul-interval-old neg neg)
              "neg * neg")
(assert-equal (mul-interval neg span)
              (mul-interval-old neg span)
              "neg * span")
(assert-equal (mul-interval span pos)
              (mul-interval-old span pos)
              "span * pos")
(assert-equal (mul-interval span neg)
              (mul-interval-old span neg)
              "span * neg")
(assert-equal (mul-interval span span)
              (mul-interval-old span span)
              "span * span")

(newline)
