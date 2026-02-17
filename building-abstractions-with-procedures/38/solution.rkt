#lang sicp

(define (cont-frac n d k)
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

(+ (cont-frac
    (lambda (i) 1.0)
    (lambda (i)
      (let ((n (- i 2)))
        (cond ((or (= i 1)
                   (= i 2))
               i)
              ((not (= (remainder n 3) 0))
               1)
              (else (+ (* (/ n 3)
                          2)
                       2)))))
    40)
   2)
