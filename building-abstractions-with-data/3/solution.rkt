#lang sicp

(define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (make-point x y) (cons x y))
(define (x-point pt) (car pt))
(define (y-point pt) (cdr pt))



(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))

(define (make-segment start end) (cons start end))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (midpoint-segment s)
  (make-point (average (x-point (start-segment s))
                       (x-point (end-segment s)))
              (average (y-point (start-segment s))
                       (y-point (end-segment s)))))

(define (length-segment s)
  (let ((x1 (x-point (start-segment s)))
        (y1 (y-point (start-segment s)))
        (x2 (x-point (end-segment s)))
        (y2 (y-point (end-segment s))))
    (sqrt (+ (square (- x2 x1))
             (square (- y2 y1))))))

(define (make-rectangle p1 p2 p3 p4)
  (let ((s1 (make-segment p1 p2))
        (s2 (make-segment p2 p3))
        (s3 (make-segment p3 p4))
        (s4 (make-segment p4 p1)))
    (cons s1 (cons s2 (cons s3 s4)))))
(define (height rect)
  (let ((s (car (cdr rect))))
    (length-segment s)))
(define (width rect)
  (let ((s (car rect)))
    (length-segment s)))

(define (make-rectangle-2 origin height width)
  (cons origin (cons height width)))
(define (height-2 rect) (car (cdr rect)))
(define (width-2 rect) (cdr (cdr rect)))

(define (perimeter rect)
  (* 2 (+ (height rect)
          (width rect))))

(define (area rect)
  (* (height rect)
     (width rect)))

;; Tests for representation 1 (4 points)
(define r1 (make-rectangle (make-point 0 0)
                           (make-point 3 0)
                           (make-point 3 4)
                           (make-point 0 4)))
(display "=== Representation 1 Tests ===") (newline)
(display "Width (expect 3): ")     (display (width r1))     (newline)
(display "Height (expect 4): ")    (display (height r1))    (newline)
(display "Perimeter (expect 14): ")(display (perimeter r1)) (newline)
(display "Area (expect 12): ")     (display (area r1))      (newline)

;; Test with a different rectangle
(define r2 (make-rectangle (make-point 1 1)
                           (make-point 6 1)
                           (make-point 6 3)
                           (make-point 1 3)))
(display "Width (expect 5): ")     (display (width r2))     (newline)
(display "Height (expect 2): ")    (display (height r2))    (newline)
(display "Perimeter (expect 14): ")(display (perimeter r2)) (newline)
(display "Area (expect 10): ")     (display (area r2))      (newline)

;; Tests for representation 2 (origin + dimensions)
(define r3 (make-rectangle-2 (make-point 0 0) 4 3))
(display "=== Representation 2 Tests ===") (newline)
(display "Width (expect 3): ")     (display (width-2 r3))   (newline)
(display "Height (expect 4): ")    (display (height-2 r3))  (newline)
