#lang sicp

(define random-init 3)

(define (rand-update x)
  (remainder (+ (* 7 x) 8) 9))

(define (random-generator)
  (let ((x random-init))
    (define (generate)
      (set! x (rand-update x))
      x)
    (define (reset new-val)
      (set! x new-val)
      x)
    (define (dispatch op)
      (cond ((eq? op 'generate) (generate))
            ((eq? op 'reset) reset)
            (else (error "Unknown request: RAND" op))))
    dispatch))

(define rand (random-generator))

;; Try generating a few values.
(rand 'generate)
(rand 'generate)
(rand 'generate)

;; Resetting to the initial value should repeat the sequence.
((rand 'reset) random-init)
(rand 'generate)
(rand 'generate)
(rand 'generate)
