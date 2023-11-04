#lang sicp

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (cube x)
  (* x x x))

(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (simpson-integral f a b n)
  (define h
    (/ (- b a)
       n))
  (define (next x)
    (+ x (* 2 h)))
  (define (even? x)
    (= (remainder x 2) 0))
  (* (/ h 3.0)
     (+ (f a)
        (* 4 (sum f
                  (+ a h)
                  next
                  (if (even? n)
                      (* (- n 1) h)
                      (* (- n 2) h))))
        (* 2 (sum f
                  (+ a (* 2 h))
                  next
                  (if (even? n)
                      (* (- n 2) h)
                      (* (- n 1) h))))
        (f b))))

(integral cube 0 1 0.01)
(integral cube 0 1 0.001)

(simpson-integral cube 0 1 100)
(simpson-integral cube 0 1 1000)