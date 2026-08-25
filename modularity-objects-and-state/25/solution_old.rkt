#lang sicp

(define (make-table)
  (let ((table (list '*table*)))
    (define (assoc key records)
      (cond ((null? records) #f)
            ((equal? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    (define (record? table)
      (not (pair? (cdr table))))
    (define (converted-table? table)
      (and (pair? (cdr table))
           (eq? (caadr table) '*value*)))
    (define (record->table record)
      (set-cdr! record
                (cons (cons '*value* (cdr record))
                      '()))
      record)
    (define (lookup keys table)
      (cond ((null? keys)
             (if (converted-table? table)
                 (if (null? (cdadr table))
                     #f
                     (cdadr table))
                 (cdr table)))
            ((null? table) #f)
            (else
             (let ((key (car keys)))
               (let ((subtable
                     (assoc key
                            (if (record? table)
                                '()
                                (cdr table)))))
                 (if subtable
                     (lookup (cdr keys) subtable)
                     #f))))))
    (define (insert! keys value table)
      (if (null? keys)
          (if (converted-table? table)
              (set-cdr! (cadr table) value)
              (set-cdr! table value))
          (let ((key (car keys))
                (rest-keys (cdr keys)))
            (let ((subtable
                  (assoc key
                         (if (record? table)
                             (cdr (record->table table))
                             (cdr table)))))
              (if subtable
                  (insert! rest-keys value subtable)
                  (let ((new-subtable (list key)))
                    (insert! rest-keys value new-subtable)
                    (if (converted-table? table)
                        (set-cdr! (cdr table)
                                  (cons new-subtable
                                        (cddr table)))
                        (set-cdr! table
                                  (cons new-subtable
                                        (cdr table))))))))))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc)
             (lambda (keys)
               (lookup keys table)))
            ((eq? m 'insert-proc!)
             (lambda (keys value)
               (insert! keys value table)
               'ok))
            (else (error "Unknown operation: TABLE" m))))
    dispatch))
(define table (make-table))
(define get (table 'lookup-proc))
(define put (table 'insert-proc!))

(display "Insert value for keys (a): ")
(display (put '(a) 1))
(newline)

(display "Lookup keys (a): ")
(display (get '(a)))
(newline)

(display "Insert value for keys (a b): ")
(display (put '(a b) 2))
(newline)

(display "Lookup keys (a b): ")
(display (get '(a b)))
(newline)

(display "Lookup keys (a): ")
(display (get '(a)))
(newline)

(display "Insert value for keys (a): ")
(display (put '(a) 3))
(newline)

(display "Lookup keys (a): ")
(display (get '(a)))
(newline)

(display "Lookup keys (a b): ")
(display (get '(a b)))
(newline)

(display "Insert value for keys (x y z): ")
(display (put '(x y z) 3))
(newline)

(display "Lookup keys (x y z): ")
(display (get '(x y z)))
(newline)
