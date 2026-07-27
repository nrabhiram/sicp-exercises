#lang sicp

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (square x) (* x x))

(define (rand-point)
  (let ((x1 0)
        (x2 0)
        (y1 0)
        (y2 0))
    (define (set-boundary x1-new x2-new y1-new y2-new)
      (set! x1 x1-new)
      (set! x2 x2-new)
      (set! y1 y1-new)
      (set! y2 y2-new))
    (define (random-point)
      (let ((x-rand (random-in-range x1 x2))
            (y-rand (random-in-range y1 y2)))
        (list x-rand y-rand)))
    (define (dispatch op)
      (cond ((eq? op 'set-boundary) set-boundary)
            ((eq? op 'random-point) random-point)
            (else (error "Unknown request: RAND-POINT" op))))
    dispatch))
(define point-generator (rand-point))
(define (set-boundary x1 x2 y1 y2)
  ((point-generator 'set-boundary) x1 x2 y1 y2))
(define (random-point)
  ((point-generator 'random-point)))

(define (circle x y r)
  (define (within-circle? x1 y1)
    (<= (+ (square (- x1 x))
           (square (- y1 y)))
        (square r)))
  within-circle?)

;; we assume that the rectangle isn't rotated
;; and matches the orientation of the axes
;; when we calculate the area
(define (estimate-integral P x1 x2 y1 y2 trials)
  (set-boundary x1 x2 y1 y2)
  (let ((rect-area (abs (* (- x1 x2)
                           (- y1 y2)))))
    (* rect-area
       (monte-carlo trials
                    (lambda ()
                      (let ((pt (random-point)))
                        (let ((x (car pt))
                              (y (cadr pt)))
                          (P x y))))))))

(define (circle-area x y r trials)
  (let ((x1 (- x r))
        (y1 (- y r))
        (x2 (+ x r))
        (y2 (+ y r))
        (within-circle? (circle x y r)))
    (estimate-integral within-circle? x1 x2 y1 y2 trials)))

(define (approx-pi)
  (/ (circle-area 0.5 0.5 0.5 1000) (square 0.5)))

(approx-pi)
