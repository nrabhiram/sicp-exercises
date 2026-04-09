#lang sicp

(define empty-board nil)

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (filter pred seq)
  (cond ((null? seq) nil)
        ((pred (car seq))
         (cons (car seq)
               (filter pred (cdr seq))))
        (else (filter pred (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (enumerate-interval start end)
  (if (<= start end)
      (cons start (enumerate-interval (+ start 1) end))
      nil))

(define (adjoin-position row col positions)
  (cons (list row col) positions))

(define (diagonal? p1 p2)
  (let ((row-distance (abs (- (car p1) (car p2))))
        (col-distance (abs (- (cadr p1) (cadr p2)))))
    (= row-distance col-distance)))

(define (same-row? p1 p2)
  (= (car p1) (car p2)))

(define (same-col? p1 p2)
  (= (cadr p1) (cadr p2)))

(define (can-check? p1 p2)
  (or (diagonal? p1 p2)
      (same-row? p1 p2)
      (same-col? p1 p2)))

(define (safe? k positions)
  (define (test-safe k first-pos rem-positions)
    (cond ((= k 0) #t)
          ((not (can-check? first-pos (car rem-positions)))
           (test-safe (- k 1) first-pos (cdr rem-positions)))
          (else #f)))

  (test-safe (- k 1) (car positions) (cdr positions)))

(define (queens-internal board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (queens board-size)
  (let ((solutions (queens-internal board-size)))
    (define (print-row row positions)
      (for-each
       (lambda (col)
         (if (member (list row col) positions)
             (display "Q ")
             (display ". ")))
       (enumerate-interval 1 board-size))
      (newline))
    (define (print-board positions)
      (for-each
       (lambda (row) (print-row row positions))
       (enumerate-interval 1 board-size))
      (newline))
    (for-each print-board solutions)
    (display "total number of solutions for ")
    (display board-size)
    (display "×")
    (display board-size)
    (display " board is: ")
    (display (length solutions))
    (newline)))

(queens 8)
