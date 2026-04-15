#lang sicp

(define (for-each proc items)
  (define (iter items)
    (cond ((null? items) #t)
          (else
           (proc (car items))
           (iter (cdr items)))))

  (iter items))

(define (make-vect x y) (list x y))
(define (x-cor-vect v) (car v))
(define (y-cor-vect v) (cadr v))

(define (add-vect v1 v2)
  (make-vect (+ (x-cor-vect v1) (x-cor-vect v2))
             (+ (y-cor-vect v1) (y-cor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (x-cor-vect v1) (x-cor-vect v2))
             (- (y-cor-vect v1) (y-cor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s (x-cor-vect v))
             (* s (y-cor-vect v))))

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame f) (car f))
(define (edge1-frame f) (cadr f))
(define (edge2-frame f) (caddr f))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (x-cor-vect v) (edge1-frame frame))
                 (scale-vect (y-cor-vect v) (edge2-frame frame))))))

(define (make-segment start end) (list start end))
(define (start-segment s) (car s))
(define (end-segment s) (cadr s))

(define (segments->painter segments)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame)
         (start-segment segment))
        ((frame-coord-map frame)
         (end-segment segment))))
     segments)))

(define origin (make-vect 0 0))
(define p1 (make-vect 1 0))
(define p2 (make-vect 1 1))
(define p3 (make-vect 0 1))
(define mp1 (make-vect 0.5 0))
(define mp2 (make-vect 1 0.5))
(define mp3 (make-vect 0.5 1))
(define mp4 (make-vect 0 0.5))

(define (outline frame)
  ((segments->painter
    (list (make-segment origin p1)
          (make-segment p1 p2)
          (make-segment p2 p3)
          (make-segment p3 origin)))
   frame))

(define (x frame)
  ((segments->painter
    (list (make-segment p3 p1)
          (make-segment p2 origin)))
   frame))

(define (diamond frame)
  ((segments->painter
    (list (make-segment mp1 mp2)
          (make-segment mp2 mp3)
          (make-segment mp3 mp4)
          (make-segment mp4 mp1)))
   frame))

;; generated with claude
(define (wave frame)
  ((segments->painter
    (list
     ;; left leg outer → left arm (lower)
     (make-segment (make-vect 0.25 0) (make-vect 0.35 0.45))
     (make-segment (make-vect 0.35 0.45) (make-vect 0.30 0.60))
     (make-segment (make-vect 0.30 0.60) (make-vect 0.15 0.40))
     (make-segment (make-vect 0.15 0.40) (make-vect 0.00 0.65))
     ;; left arm (upper) → head left
     (make-segment (make-vect 0.00 0.85) (make-vect 0.15 0.60))
     (make-segment (make-vect 0.15 0.60) (make-vect 0.30 0.65))
     (make-segment (make-vect 0.30 0.65) (make-vect 0.40 0.65))
     (make-segment (make-vect 0.40 0.65) (make-vect 0.35 0.85))
     (make-segment (make-vect 0.35 0.85) (make-vect 0.40 1.00))
     ;; head right → right arm (upper)
     (make-segment (make-vect 0.60 1.00) (make-vect 0.65 0.85))
     (make-segment (make-vect 0.65 0.85) (make-vect 0.60 0.65))
     (make-segment (make-vect 0.60 0.65) (make-vect 0.75 0.65))
     (make-segment (make-vect 0.75 0.65) (make-vect 1.00 0.40))
     ;; right arm (lower) → right leg outer
     (make-segment (make-vect 1.00 0.25) (make-vect 0.70 0.50))
     (make-segment (make-vect 0.70 0.50) (make-vect 0.65 0.45))
     (make-segment (make-vect 0.65 0.45) (make-vect 0.75 0.00))
     ;; inner legs
     (make-segment (make-vect 0.35 0.00) (make-vect 0.45 0.25))
     (make-segment (make-vect 0.45 0.25) (make-vect 0.48 0.30))
     (make-segment (make-vect 0.48 0.30) (make-vect 0.52 0.30))
     (make-segment (make-vect 0.52 0.30) (make-vect 0.55 0.25))
     (make-segment (make-vect 0.55 0.25) (make-vect 0.65 0.00))))
   frame))
