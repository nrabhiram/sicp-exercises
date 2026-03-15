#lang sicp

(define (for-each proc items)
  (define (iter items)
    (cond ((null? items) #t)
          (else
           (proc (car items))
           (iter (cdr items)))))

  (iter items))

(for-each (lambda (x)
            (newline)
            (display x))
          (list 57 321 88))
