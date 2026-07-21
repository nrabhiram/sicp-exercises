#lang sicp

(define (make-monitored f)
  (let ((counter 0))
    (lambda (input)
      (cond ((eq? input 'how-many-calls?) counter)
            ((eq? input 'reset-count)
             (set! counter 0)
             counter)
            (else
             (set! counter (+ counter 1))
             (f input))))))

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
(s 'reset-count)
