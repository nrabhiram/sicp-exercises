#lang sicp

(define (cont-frac-recur n d k)
  (define (compute-frac i)
    (cond ((= i k)
           (/ (n i) (d i)))
          (else
           (/ (n i)
              (+ (d i)
                 (compute-frac (+ i 1)))))))
  (compute-frac 1))

(define (cont-frac-iter n d k)
  (define (compute-frac num den acc)
    (if (= acc 0)
        (/ num den)
        (compute-frac (n acc) (+ (d acc) (/ num den)) (- acc 1))))
  (compute-frac 0 1 k))

(cont-frac-recur (lambda (i) 1.0)
                 (lambda (i)
                   (let ((rem (remainder i 3))
                         (set (+ (quotient i 3) 1)))
                     (cond ((= rem 2)
                            (* set 2))
                           (else 1))))
                 11)
(cont-frac-iter (lambda (i) 1.0)
                 (lambda (i)
                   (let ((rem (remainder i 3))
                         (set (+ (quotient i 3) 1)))
                     (cond ((= rem 2)
                            (* set 2))
                           (else 1))))
                 11)