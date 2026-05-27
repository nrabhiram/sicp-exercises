#lang sicp

(define *table* '())

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

(define (variable? exp) (symbol? exp))
(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (make-sum a1 a2)
  (cond ((and (number? a1) (= a1 0)) a2)
        ((and (number? a2) (= a2 0)) a1)
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((and (number? m1) (= m1 0)) 0)
        ((and (number? m1) (= m1 1)) m2)
        ((and (number? m2) (= m2 0)) 0)
        ((and (number? m2) (= m2 1)) m1)
        (else (list '* m1 m2))))

(define (make-exponentation b e)
  (cond ((=number? e 1) b)
        ((=number? e 0) 1)
        (else (list '** b e))))

(define (install-sum-derivative-package)
  (define (addend operands) (car operands))
  (define (augend operands) (cadr operands))
  (define (deriv-sum operands var)
    (make-sum (deriv (addend operands) var)
              (deriv (augend operands) var)))
  (put 'deriv '+ deriv-sum)
  'done)

(define (install-product-derivative-package)
  (define (multiplier operands) (car operands))
  (define (multiplicand operands) (cadr operands))
  (define (deriv-product operands var)
    (make-sum (make-product
               (multiplier operands)
               (deriv (multiplicand operands) var))
              (make-product
               (deriv (multiplier operands) var)
               (multiplicand operands))))
  (put 'deriv '* deriv-product)
  'done)

(define (install-exponentation-derivative-package)
  (define (base operands) (car operands))
  (define (exponent operands) (cadr operands))
  (define (deriv-exponentation exp var)
    (make-product
     (make-product (exponent exp)
                   (make-exponentation
                    (base exp)
                    (- (exponent exp) 1)))
     (deriv (base exp) var)))
  (put 'deriv '** deriv-exponentation)
  'done)

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))

(install-sum-derivative-package)
(install-product-derivative-package)
(install-exponentation-derivative-package)

;; deriv of a constant is 0
(deriv 5 'x)

;; deriv of the same variable is 1
(deriv 'x 'x)

;; deriv of a different variable is 0
(deriv 'y 'x)

;; d/dx (x + 3) = 1
(deriv '(+ x 3) 'x)

;; d/dx (x * y) = y
(deriv '(* x y) 'x)

;; d/dx (x * x) = x + x
(deriv '(* x x) 'x)

;; d/dx ((x + 1) * (x + 2)) = (x + 1) + (x + 2)
(deriv '(* (+ x 1) (+ x 2)) 'x)

;; d/dx (x + (x * 3)) = 1 + 3
(deriv '(+ x (* x 3)) 'x)

;; d/dx ((x * x) + (x * x)) = (x + x) + (x + x)
(deriv '(+ (* x x) (* x x)) 'x)

;; d/dx (x ** 3) = 3 * x^2
(deriv '(** x 3) 'x)

;; d/dx (x ** 1) = 1
(deriv '(** x 1) 'x)

;; d/dx ((x ** 2) + (x ** 3)) = 2x + 3x^2
(deriv '(+ (** x 2) (** x 3)) 'x)

;; d/dx ((x + 1) ** 3) = 3 * (x + 1)^2
(deriv '(** (+ x 1) 3) 'x)
