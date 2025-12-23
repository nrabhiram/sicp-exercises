#lang sicp

(define (square x) (* x x))

(define (make-point x y) (cons x y))
(define (x-point pt) (car pt))
(define (y-point pt) (cdr pt))

(define (dot-product p1 p2)
  (+ (* (x-point p1) (x-point p2))
     (* (y-point p1) (y-point p2))))
(define (add-vector v1 v2)
  (make-point (+ (x-point v1) (x-point v2))
              (+ (y-point v1) (y-point v2))))
(define (sub-vector v1 v2)
  (make-point (- (x-point v1) (x-point v2))
              (- (y-point v1) (y-point v2))))
(define (orthogonal? v1 v2)
  (= 0.0 (dot-product v1 v2)))

(define (distance p1 p2)
  (let ((x1 (x-point p1))
        (x2 (x-point p2))
        (y1 (y-point p1))
        (y2 (y-point p2)))
    (sqrt (+ (square (- x2 x1))
             (square (- y2 y1))))))

(define (make-rect origin height width)
  (cons origin
        (cons height width)))
(define (height rect)
  (car (cdr rect)))
(define (width rect)
  (cdr (cdr rect)))

(define (perimeter-rect rect)
  (* 2
     (+ (width rect)
        (height rect))))
(define (area-rect rect)
  (* (width rect)
     (height rect)))

(define (make-rect-2 p1 p2 p3)
  (if (orthogonal? (sub-vector p2 p1) (sub-vector p3 p1))
      (cons p1 (cons p2 p3))
      (error "Points should make an rectangle.")))
(define (height-2 rect)
  (distance (car rect)
            (cdr (cdr rect))))
(define (width-2 rect)
  (distance (car rect)
            (car (cdr rect))))

(define (perimeter-rect-2 rect)
  (* 2
     (+ (width-2 rect)
        (height-2 rect))))
(define (area-rect-2 rect)
  (* (width-2 rect)
     (height-2 rect)))

(define rect-1 (make-rect (make-point 0 0) 5 4))
(define rect-2 (make-rect-2 (make-point 0 0)
                            (make-point 10 -2)
                            (make-point 1 5)))

(display "Rectangle 1: ") (newline)
(display "Perimeter: ") (display (perimeter-rect rect-1)) (newline)
(display "Area ") (display (area-rect rect-1)) (newline) (newline)
(display "Rectangle 2: ") (newline)
(display "Perimeter: ") (display (perimeter-rect-2 rect-2)) (newline)
(display "Area ") (display (area-rect-2 rect-2)) (newline) (newline)