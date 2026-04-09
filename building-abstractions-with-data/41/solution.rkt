#lang sicp

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

(define (unique-triples n)
  (flatmap
   (lambda (i)
     (flatmap
      (lambda (j)
        (map
         (lambda (k)
           (list i j k))
         (enumerate-interval 1 (- j 1))))
      (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (sum s)
  (lambda (triple)
    (= (+ (car triple)
          (cadr triple)
          (caddr triple))
       s)))

(define (sum-triples n s)
  (filter (sum s) (unique-triples n)))

(sum-triples 6 9)
