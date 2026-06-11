#lang sicp

(define *table* '())
(define *coercion-table* '())

(define (put op type item)
  (set! *table* (cons (list op type item) *table*)))
(define (get op type)
  (define (lookup key table)
    (cond ((null? table) #f)
          ((and (equal? (caar table) op)
                (equal? (cadar table) type))
           (caddar table))
          (else (lookup key (cdr table)))))
  (lookup (list op type) *table*))

(define (put-coercion from to proc)
  (set! *coercion-table* (cons (list from to proc) *coercion-table*)))
(define (get-coercion from to)
  (define (lookup table)
    (cond ((null? table) #f)
          ((and (equal? (caar table) from)
                (equal? (cadar table) to))
           (caddar table))
          (else (lookup (cdr table)))))
  (lookup *coercion-table*))

(define (attach-tag type-tag contents)
  (if (number? contents)
      contents
      (cons type-tag contents)))
(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((number? datum) 'scheme-number)
        (else (error "bad tagged datum: TYPE-TAG" datum))))
(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((number? datum) datum)
        (else (error "bad tagged datum: CONTENTS" datum))))
(define (apply-generic op . args)
  (define (coerce-obj coerce-type obj)
    (let ((coerce-proc
           (get-coercion (type-tag obj) coerce-type)))
      (if coerce-proc
          (coerce-proc obj)
          #f)))
  (define (coerce-remaining-args
           ele-num coerce-ele-num
           coerce-type rem-args
           coerced-res terminate?)
    (cond (terminate? nil)
          ((> ele-num (length args))
           coerced-res)
          ((= ele-num coerce-ele-num)
           (coerce-remaining-args
            (+ ele-num 1)
            coerce-ele-num
            coerce-type
            (cdr rem-args)
            (append coerced-res (list (car rem-args)))
            #f))
          (else
           (let ((coerced-obj 
                  (coerce-obj coerce-type (car rem-args))))
             (coerce-remaining-args
              (+ ele-num 1)
              coerce-ele-num
              coerce-type
              (cdr rem-args)
              (append coerced-res (list coerced-obj))
              (if coerced-obj #f #t))))))
  (define (try-coercion coerce-ele-num remaining-args)
    (if (> coerce-ele-num (length args))
        #f
        (let ((coercion-args
               (coerce-remaining-args
                1
                coerce-ele-num
                (type-tag (car remaining-args))
                args
                nil
                #f)))
          (if (and (not (null? coercion-args))
                   (get op (map type-tag coercion-args)))
              coercion-args
              (try-coercion
               (+ coerce-ele-num 1)
               (cdr remaining-args))))))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((coercion-args (try-coercion 1 args)))
            (if coercion-args
                (apply apply-generic (cons op coercion-args))
                (error "No method for these types"
                       (list op type-tags))))))))

(define (square x) (* x x))

(define (install-polar-package)
  ;; internal procedures
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  ;; interface to the rest of the system
  (define (tag z) (attach-tag 'polar z))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  'done)
(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-real-imag x y) (cons x y))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a))
          (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag z) (attach-tag 'rectangular z))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  'done)
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))
(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))

(define (install-scheme-number-package)
  (define (tag x) (attach-tag 'scheme-number x))
  ;; coercion procedures
  (define (scheme-number->complex n)
    (make-complex-from-real-imag (contents n) 0))
  (define (scheme-number->scheme-number n) n)
  ;; interface to rest of the system
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'exp '(scheme-number scheme-number)
    (lambda (x y) (tag (expt x y)))) ; using primitive expt
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y)))
  (put '=zero? '(scheme-number)
       (lambda (x) (= x 0)))
  (put 'make 'scheme-number (lambda (x) (tag x)))
  (put-coercion 'scheme-number
                'complex
			    scheme-number->complex)
  (put-coercion 'scheme-number
                'scheme-number
                scheme-number->scheme-number)
  'done)
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; coercion procedures
  (define (complex->complex z) z)
  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))
  (define (equ? z1 z2)
    (and (= (real-part z1) (real-part z2))
         (= (imag-part z1) (imag-part z2))))
  (define (=zero? z)
    (equ? z (make-from-real-imag 0 0)))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'equ? '(complex complex) equ?)
  (put '=zero? '(complex) =zero?)
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  (put-coercion 'complex 'complex complex->complex)
  'done)
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(define (exp x y) (apply-generic 'exp x y))

(install-polar-package)
(install-rectangular-package)
(install-scheme-number-package)
(install-complex-package)

(exp (make-scheme-number 2) (make-scheme-number 4))
(exp (make-complex-from-real-imag 2 4) (make-complex-from-real-imag 3 5))
