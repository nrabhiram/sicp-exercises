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
     (make-segment (make-vect 0.55 0.25) (make-vect 0.65 0.00))
     ;; smile
     (make-segment (make-vect 0.43 0.88) (make-vect 0.50 0.85))
     (make-segment (make-vect 0.50 0.85) (make-vect 0.57 0.88))
     ;; left eye
     (make-segment (make-vect 0.44 0.93) (make-vect 0.46 0.93))
     ;; right eye
     (make-segment (make-vect 0.54 0.93) (make-vect 0.56 0.93))))
    frame))

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame new-origin
                             (sub-vect (m corner1) new-origin)
                             (sub-vect (m corner2) new-origin)))))))

(define (identity painter) painter)

(define (flip-horiz painter)
  (transform-painter
   painter
   (make-vect 1.0 0.0)
   (make-vect 0.0 0.0)
   (make-vect 1.0 1.0)))

(define (flip-vert painter)
  (transform-painter painter
					 (make-vect 0.0 1.0)
					 (make-vect 1.0 1.0)
					 (make-vect 0.0 0.0)))

(define (rotate90 painter)
  (transform-painter painter
					 (make-vect 1.0 0.0)
					 (make-vect 1.0 1.0)
					 (make-vect 0.0 0.0)))

(define (rotate180 painter)
  (transform-painter
   painter
   (make-vect 1.0 1.0)
   (make-vect 0.0 1.0)
   (make-vect 1.0 0.0)))

(define (rotate270 painter)
  (transform-painter
   painter
   (make-vect 0.0 1.0)
   (make-vect 0.0 0.0)
   (make-vect 1.0 1.0)))

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-top
           (transform-painter
            painter2
            split-point
            (make-vect 1.0 0.5)
            (make-vect 0.0 1.0)))
          (paint-bottom
           (transform-painter
            painter1
            (make-vect 0.0 0.0)
            (make-vect 1.0 0.0)
            split-point)))
      (lambda (frame)
        (paint-top frame)
        (paint-bottom frame)))))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
		   (transform-painter
		    painter1
		    (make-vect 0.0 0.0)
		    split-point
		    (make-vect 0.0 1.0)))
		  (paint-right
		   (transform-painter
		    painter2
		    split-point
		    (make-vect 1.0 0.0)
		    (make-vect 0.5 1.0))))
	  (lambda (frame)
	    (paint-left frame)
	    (paint-right frame)))))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (split combiner splitter)
  (define (do p n)
    (if (= n 0)
        p
        (let ((smaller (do p (- n 1))))
          (combiner p (splitter smaller smaller)))))

  (lambda (painter n) (do painter n)))

(define right-split (split beside below))
(define up-split (split below beside))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((top-left (up-split painter n))
            (bottom-right (right-split painter n))
            (corner (corner-split painter (- n 1))))
        (beside (below painter top-left)
                (below bottom-right corner)))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (square-limit painter n)
  (let ((combine4 (square-of-four (compose flip-horiz rotate180)
                                  rotate180
                                  identity
                                  (compose flip-vert rotate180))))
    (combine4 (corner-split painter n))))
