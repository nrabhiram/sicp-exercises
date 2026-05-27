#lang sicp

(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part)
           (* r (cos a)))
          ((eq? op 'imag-part)
           (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)))
  dispatch)

(define (apply-generic op arg) (arg op))

; Tests
(define z1 (make-from-mag-ang 1 0))
(display (apply-generic 'magnitude z1))  ; 1
(newline)
(display (apply-generic 'angle z1))      ; 0
(newline)
(display (apply-generic 'real-part z1))  ; 1
(newline)
(display (apply-generic 'imag-part z1))  ; 0
(newline)

(define z2 (make-from-mag-ang 2 (/ 3.14159 2)))
(display (apply-generic 'magnitude z2))  ; 2
(newline)
(display (apply-generic 'real-part z2))  ; ~0
(newline)
(display (apply-generic 'imag-part z2))  ; ~2
(newline)
