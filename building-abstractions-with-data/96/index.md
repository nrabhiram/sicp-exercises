---
slug: exercise-2-96
name: Exercise 2.96
date: 13-07-26 04:17
---

a. Implement the procedure `pseudoremainder-terms`, which is just like `remainder-terms` except that it multiplies the dividend by the integerizing factor described above before calling `div-terms`. Modify `gcd-terms` to use `pseudoremainder-terms`, and verify that `greatest-common-divisor` now produces an answer with integer coefficients on the example in [Exercise 2.95](/exercise-2-95).
b. The GCD now has integer coefficients, but they are larger than those of *P*₁. Modify `gcd-terms` so that it removes common factors from the coefficients of the answer by dividing all the coefficients by their (integer) greatest common divisor.

## Solution

A problem that I came across when implementing `psuedoremainder-terms` and using it in `gcd-terms` was that the division of integers in our system always created rational numbers, regardless of whether the two numbers could be divided evenly. So, in `psuedoremainder-terms`, when we calculate the integerizing factor (in the subsequent iterative `gcd-terms` calls), the program errored out, because the primitive `expt` procedure expects a primitive number, but it receives a rational number from our arithmetic system.

```
expt: contract violation
  expected: number?
  given: (rational 3203226 . 2197)
```

Modifying the `div` operation in the integer package to return integers if the division is even fixes this.

```racket
(put 'div '(integer integer)
     (lambda (x y)
       (if (= (remainder x y) 0)
           (/ x y)
           (make-rational x y))))
```

Now, when we run the program, we get the following output:

```
p1-poly: (1*x^2 + -2*x + 1)
p2-poly: (11*x^2 + 7)
p3-poly: (13*x + 5)
q1-poly: (11*x^4 + -22*x^3 + 18*x^2 + -14*x + 7)
q2-poly: (13*x^3 + -21*x^2 + 3*x + 5)
gcd q1 q2: (1458*x^2 + -2916*x + 1458)
```

For part *b*, we create a helper procedure in the termlist package that constructs a list of the coefficients of terms by using the interface procedures `empty-termlist?`, `first-term`, and `rest-terms` so that the type tags are stripped and we can manipulate the data correctly.

```racket
(define (scale-terms f L)
  (if (empty-termlist? L)
      (the-empty-termlist L)
      (let ((t (first-term L)))
        (adjoin-term
         (make-term (order t)
                    (mul f (coeff t)))
         (scale-terms f (rest-terms L))))))
(define (pseudoremainder-terms L1 L2)
  (let ((t1 (first-term L1))
        (t2 (first-term L2)))
    (let ((o1 (order t1))
          (o2 (order t2))
          (c (coeff t2)))
      (let ((factor (expt c (+ 1 (- o1 o2)))))
        (remainder-terms
         (scale-terms factor L1) L2)))))
(define (term-coeffs L)
  (if (empty-termlist? L)
      '()
      (cons (coeff (first-term L))
            (term-coeffs (rest-terms L)))))
(define (find-terms-coeff-gcd L)
  (apply gcd (term-coeffs L)))
(define (gcd-terms L1 L2)
  (if (=zero-terms? L2)
      (scale-terms (/ 1 (find-terms-coeff-gcd L1)) L1)
      (gcd-terms L2 (pseudoremainder-terms L1 L2))))
```

Now, this is the output of our program:

```
p1-poly: (1*x^2 + -2*x + 1)
p2-poly: (11*x^2 + 7)
p3-poly: (13*x + 5)
q1-poly: (11*x^4 + -22*x^3 + 18*x^2 + -14*x + 7)
q2-poly: (13*x^3 + -21*x^2 + 3*x + 5)
gcd q1 q2: (1*x^2 + -2*x + 1)
```
