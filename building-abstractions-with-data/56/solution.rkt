#lang sicp

(define (variable? e) (symbol? e))
(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))
(define (addend s) (cadr s))
(define (augend s) (caddr s))
(define (sum? e)
  (and (pair? e)
       (eq? (car e) '+)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        (else (list '* m1 m2))))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))
(define (product? e)
  (and (pair? e)
       (eq? (car e) '*)))

(define (make-exponentation b e)
  (cond ((=number? e 1) b)
        ((=number? e 0) 1)
        (else (list '** b e))))
(define (base e) (cadr e))
(define (exponent e) (caddr e))
(define (exponentation? e)
  (and (pair? e)
       (eq? (car e) '**)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (multiplicand exp)
                         (deriv (multiplier exp) var))))
        ((exponentation? exp)
         (make-product
           (make-product (exponent exp)
                         (make-exponentation
                           (base exp)
                           (- (exponent exp) 1)))
           (deriv (base exp) var)))
        (else (error "unknown expression type: DERIV" exp))))

; d/dx (x^3) = 3x^2
(deriv '(** x 3) 'x)

; d/dx (x^1) = 1
(deriv '(** x 1) 'x)

; d/dx (x^0) = 0
(deriv '(** x 0) 'x)

; d/dx (x + x^3) = 1 + 3x^2
(deriv '(+ x (** x 3)) 'x)

; d/dx (2 * x^4) = 2 * 4x^3 = 8x^3
(deriv '(* 2 (** x 4)) 'x)
