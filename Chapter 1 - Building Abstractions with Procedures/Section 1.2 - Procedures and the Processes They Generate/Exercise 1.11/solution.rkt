#lang sicp

(define (f-recursive n)
  (if (< n 3)
      n
      (+ (f-recursive (- n 1))
         (* 2 (f-recursive (- n 2)))
         (* 3 (f-recursive (- n 3))))))

(define (f-iterative n)
  (define (seed x)
    (if (< x 0)
        0
        x))
  (define (f-iter a b c counter)
    (cond ((> counter n) a)
          ((< counter 3) (f-iter (seed counter)
                                 (seed (- counter 1))
                                 (seed (- counter 2))
                                 (+ counter 1)))
          (else (f-iter (+ a
                           (* 2 b)
                           (* 3 c))
                        a
                        b
                        (+ counter 1)))))
  (f-iter 0 0 0 0))

(f-recursive 2)
(f-recursive 3)
(f-recursive 4)
(f-recursive 5)

(f-iterative 2)
(f-iterative 3)
(f-iterative 4)
(f-iterative 5)