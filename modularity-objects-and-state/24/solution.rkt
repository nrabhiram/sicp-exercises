#lang sicp

(define (make-table same-key?)
  (let ((table (list '*table*)))
    (define (assoc key records)
      (cond ((null? records) #f)
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    (define (lookup key-1 key-2)
      (let ((subtable
             (assoc key-1 (cdr table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  #f))
            #f)))
    (define (insert! key-1 key-2 value)
      (let ((subtable
             (assoc key-1 (cdr table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

(define (make-range-detector delta)
  (define (in-range? a b)
    (<= (abs (- a b)) delta))
  in-range?)

(define table (make-table (make-range-detector 5)))
(define get (table 'lookup-proc))
(define put (table 'insert-proc!))

(display "Insert value for keys (10, 20): ")
(display (put 10 20 'a))
(newline)

(display "Lookup exact keys (10, 20): ")
(display (get 10 20))
(newline)

(display "Lookup nearby keys (12, 23), both within delta 5: ")
(display (get 12 23))
(newline)

(display "Lookup first key outside delta (16, 20): ")
(display (get 16 20))
(newline)

(display "Lookup second key outside delta (10, 26): ")
(display (get 10 26))
(newline)

(display "Insert value for nearby keys (13, 24), should update existing record: ")
(display (put 13 24 'b))
(newline)

(display "Lookup original keys (10, 20), now updated: ")
(display (get 10 20))
(newline)

(display "Insert value for distinct keys (30, 40): ")
(display (put 30 40 'c))
(newline)

(display "Lookup distinct keys (30, 40): ")
(display (get 30 40))
(newline)

(display "Lookup near distinct keys (34, 36), both within delta 5: ")
(display (get 34 36))
(newline)
