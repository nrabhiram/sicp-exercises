#lang sicp

(define (inverter input output)
  (define (invert)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! input invert)
  'ok)
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1)
                        (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)
(define (or-gate o1 o2 output)
  (define (or-action-procedure)
    (let ((new-value
           (logical-or (get-signal o1)
                       (get-signal o2))))
      (after-delay
       or-gate-delay
       (lambda ()
         (set-signal! output new-value)))))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure)
  'ok)

(define (logical-not s)
  (cond ((= s 0) 1)
	    ((= s 1) 0)
	    (else (error "Invalid signal" s))))
(define (logical-and s1 s2)
  (cond ((and (= s1 1) (= s2 1)) 1)
        ((and (= s1 0) (= s2 1)) 0)
        ((and (= s1 1) (= s2 0)) 0)
        ((and (= s1 0) (= s2 0)) 0)
        (else (error "Invalid signal" s1 s2))))
(define (logical-or s1 s2)
  (cond ((and (= s1 0) (= s2 1)) 1)
        ((and (= s1 1) (= s2 0)) 1)
        ((and (= s1 1) (= s2 1)) 1)
        ((and (= s1 0) (= s2 0)) 0)
        (else (error "Invalid signal" s1 s2))))

(define (half-adder a b s c)
  (let ((d (make-wire))
        (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

(define (ripple-carry-adder a-list b-list s-list c)
  (define (wiring-complete? wires)
    (null? wires))
  (define (last-full-adder? wires)
    (null? (cdr wires)))
  (define (perform-wiring a-list b-list s-list c-in)
    (cond ((wiring-complete? a-list) 'ok)
          ((last-full-adder? a-list)
           (full-adder
            (car a-list) (car b-list) c-in
            (car s-list) c))
          (else
           (let ((c-out (make-wire)))
             (full-adder
              (car a-list) (car b-list) c-in
              (car s-list) c-out)
             (perform-wiring
              (cdr a-list) (cdr b-list)
              (cdr s-list) c-out)))))
  (perform-wiring a-list b-list s-list (make-wire))
  'ok)
