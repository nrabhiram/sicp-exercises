#lang sicp

(define (cont-frac-recur n d k)
  (define (calc i)
    (let ((num (n i))
          (den (d i)))
      (if (> i k)
          0
          (/ num
             (+ den
                (calc (+ i 1)))))))

  (calc 1))

(define (cont-frac-iter n d k)
  (define (calc res i)
    (let ((num (n i))
          (den (d i)))
      (if (< i 1)
          res
          (let ((term
                 (/ num
                    (+ den res))))
            (calc term (- i 1))))))

  (calc 0 k))

(cont-frac-recur (lambda (i) 1.0)
                 (lambda (i) 1.0)
                 11)

(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                11)
