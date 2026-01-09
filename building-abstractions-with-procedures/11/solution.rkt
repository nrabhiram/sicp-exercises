#lang sicp

(define (f-recur n)
  (if (< n 3)
      n
      (+ (f-recur (- n 1))
         (* 2 (f-recur (- n 2)))
         (* 3 (f-recur (- n 3))))))

(f-recur 0)
(f-recur 1)
(f-recur 2)
(f-recur 3)
(f-recur 4)
(f-recur 5)

(define (f-iter n)
  (define (next-val a b c)
    (if (< (+ a 1) 3)
        (+ a 1)
        (+ a (* 2 b) (* 3 c))))
  (define (f a b c iter)
    (if (= iter n)
        a
        (f (next-val a b c)
           a
           b
           (+ iter 1))))
  (f 0 0 0 0))

(f-iter 0)
(f-iter 1)
(f-iter 2)
(f-iter 3)
(f-iter 4)
(f-iter 5)
