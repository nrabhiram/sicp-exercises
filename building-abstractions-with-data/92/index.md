---
slug: exercise-2-92
name: Exercise 2.92
date: 02-07-26 01:10
---

By imposing an ordering on variables, extend the polynomial package so that addition and multiplication of polynomials works for polynomials in different variables. (This is not easy!)

## Solution

Since we can't predetermine the variables someone would use, the most straightforward way to impose an ordering on variables is to adopt the alphabetical ordering. Scheme lets us do this with the built-in helper procedures, `string<?` and `symbol->string`.

```racket
(define (before-variable? v1 v2)
  (string<? (symbol->string v1) (symbol->string v2)))
```

When we perform the addition or multiplication of 2 polynomials that are defined in terms of different variables, we coerce the polynomial defined in the lower priority variable by transforming it into a polynomial in the other variable, with a single term that is of the 0th order. This means that the entire polynomial defined in the lower priority variable becomes a coefficient for the 0th order term.

```racket
(define (add-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (add-terms (term-list p1) (term-list p2)))
      (if (before-variable? (variable p1) (variable p2))
          (add-poly p1 (coerce-poly p2 p1))
          (add-poly (coerce-poly p1 p2) p2))))
(define (mul-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p2)
                 (mul-terms (term-list p1) (term-list p2)))
      (if (before-variable? (variable p1) (variable p2))
          (mul-poly p1 (coerce-poly p2 p1))
          (mul-poly (coerce-poly p1 p2) p2))))
```

My initial strategy for coercion was to convert each term in the polynomial defined in the lower priority variable to a 0th order polynomial in the higher priority variable. We do this by splitting the term into essentially 2 terms: the variable term and the coefficient term. We coerce them into polynomials of the higher priority variable (by making them 0th order terms) and multiply them. Then, we add all of the coerced polynomials we create for each of the terms.

```racket
(define (poly? p)
  (and (pair? p) (variable? (variable p))))
(define (poly-with-rest-terms p)
  (make-poly
   (variable p)
   (rest-terms (term-list p))))
(define (coerce-term t v1 v2)
  (let ((c (coeff t))
        (o (order t)))
    (let ((t2
           (make-poly v2
            (make-sparse-termlist
             (list (make-term 0
                    (tag (make-poly v1
                                    (make-sparse-termlist
                                     (list (make-term o 1)))))))))))
      (if (and (poly? c) (same-variable? (variable c) v2))
          (mul-poly c t2)
          (mul-poly
           (make-poly v2
                      (make-sparse-termlist (list (make-term 0 c))))
           t2)))))
(define (coerce-poly p1 p2)
  (let ((v1 (variable p1))
        (v2 (variable p2)))
    (if (empty-termlist? (term-list p1))
        (make-poly v2 (make-sparse-termlist '()))
        (add-poly
         (coerce-term (first-term p1) v1 v2)
         (coerce-poly (poly-with-rest-terms p1) p2)))))
```

I abandoned this approach because there are a couple of disadvantages that come with it.

Firstly, `coerce-term` only checks nesting that is one level deep. It looks at whether `c` is a polynomial that is defined in `v2`. If it isn't, it is directly coerced into a 0th order polynomial in `v2`. But, this is incorrect. What if `c` is defined in a variable `v3` that is actually higher priority than `v2`? By committing to `v2` as the variable we want our entire polynomial to be represented in, we lose the ability to represent our polynomials in a fully standardized form.

Secondly, this standardization is imposed at operation time. A lot of the responsibility to ensure consistency in the representation of polynomials is borne by and scattered across the procedures `coerce-term` and `coerce-poly`. This makes it difficult to visualize the process of canonicalization.

To fix these problems, we create a separate procedure `make-canonical`.

```racket
(define (poly? p)
  (eq? (type-tag p) 'polynomial))
(define (coerce-poly p1 p2)
  (let ((v (variable p2)))
    (let ((result (make-poly-with-term v 0 (tag p1))))
      result)))
(define (make-poly-with-term var order coeff)
  (make-poly
   var
   (make-sparse-termlist (list (make-term order coeff)))))
(define (make-canonical var terms)
  (if (empty-termlist? terms)
      (make-poly var (the-empty-termlist terms))
      (let ((t (first-term terms)))
        (add-poly
         (make-canonical var (rest-terms terms))
         (let ((c (coeff t))
               (o (order t)))
           (if (poly? c)
               (let ((c-poly (contents c)))
                 (let ((c-canonical
                        (make-canonical
                         (variable c-poly) (term-list c-poly))))
                   (mul-poly
                    (make-poly-with-term var o 1)
                    c-canonical)))
               (make-poly-with-term var o c)))))))
```

This procedure recursively descends into the nested coefficients and transforms each term into canonicalized polynomials, i.e. the highest priority variable in a polynomial is always the outermost variable.

We expose this `make-canonical` procedure to the rest of the system as the `make-polynomial` constructor. This ensures that every polynomial we create, regardless of the structure of the input, will be converted to its canonical form. 

If we try to test the system as is, we'll end up with errors. This is because the system doesn't yet know how to perform operations such as addition and multiplication between the various number types and a polynomial. It doesn't make sense to move polynomials to the top of the tower hierarchy — this would imply that every number has to be coerced into a complex number in order to be converted into a polynomial.

A workaround is to add `coerce-polynomial` operations in each of our packages. This operation takes as arguments, a number and the polynomial whose type (variable) we want to coerce it into.

```racket
(define (install-complex-package)
  ;; ...
  (define (complex->poly z p)
    (let ((var (variable p)))
      (make-polynomial-with-term var 0 z)))
  ;; ...
  (put 'coerce-polynomial '(complex polynomial)
       complex->poly)
  'done)

(define (coerce-polynomial obj poly)
  ((get 'coerce-polynomial
        (list (type-tag obj) (type-tag poly)))
   obj poly))
```

We'll make use of this procedure in `apply-generic`. 

```racket
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (let ((result (apply proc (map contents args))))
            (if (memq op '(add sub mul div))
                (drop result)
                result))
          (if (= (length args) 2)
              (let ((obj1 (car args))
                    (obj2 (cadr args)))
                (cond ((eq? (type-tag obj1) 'polynomial)
                       (apply-generic
                        op obj1 (coerce-polynomial obj2 obj1)))
                      ((eq? (type-tag obj2) 'polynomial)
                       (apply-generic
                        op (coerce-polynomial obj1 obj2) obj2))
                      (else
                       (let ((coerced-objs (coerce obj1 obj2)))
                         (let ((c-obj1 (car coerced-objs))
                               (c-obj2 (cadr coerced-objs)))
                           (if (eq? (type-tag c-obj1)
                                    (type-tag c-obj2))
                               (apply-generic op c-obj1 c-obj2)
                               (error "Objects do not exist in the same tower hierarchy of types: APPLY-GENERIC"
                                      (list op type-tags))))))))
              (error "No method for these types: APPLY-GENERIC"
                     (list op type-tags)))))))
```

We add clauses to check if one of the 2 arguments is a polynomial, and attempt to coerce the other argument into a polynomial of the same variable.

Here's an example for what the process of canonicalizing a polynomial looks like:

```racket
(display "=== Test 7: ((x+1)*z^2) * y^3 ===") (newline)
(define t7-x (make-polynomial 'x (make-sparse-termlist (list (list 1 1) (list 0 1)))))
(define t7-z (make-polynomial 'z (make-sparse-termlist (list (list 2 t7-x)))))
(define t7 (make-polynomial 'y (make-sparse-termlist (list (list 3 t7-z)))))
(display "result: ") (render t7) (newline) (newline)
```

Here's the output (I've added debug procedures to visualize the process):

```
=== Test 7: ((x+1)*z^2) * y^3 ===
--- begin canonicalize x-poly ---
| term: 1 * x^1
| term: 1 * x^0
|= (1)
|= (1*x + 1)
--- end canonicalize x-poly => (1*x + 1) ---
--- begin canonicalize z-poly ---
| term: (1*x + 1) * z^2
|   coeff is x-poly, canonicalizing:
  | term: 1 * x^1
  | term: 1 * x^0
  |= (1)
  |= (1*x + 1)
|   canonical coeff: (1*x + 1)
|   * z^2 => ((1*z^2)*x + (1*z^2))
|= ((1*z^2)*x + (1*z^2))
--- end canonicalize z-poly => ((1*z^2)*x + (1*z^2)) ---
--- begin canonicalize y-poly ---
| term: ((1*z^2)*x + (1*z^2)) * y^3
|   coeff is x-poly, canonicalizing:
  | term: (1*z^2) * x^1
  |   coeff is z-poly, canonicalizing:
    | term: 1 * z^2
    |= (1*z^2)
  |   canonical coeff: (1*z^2)
  |   * x^1 => ((1*z^2)*x)
  | term: (1*z^2) * x^0
  |   coeff is z-poly, canonicalizing:
    | term: 1 * z^2
    |= (1*z^2)
  |   canonical coeff: (1*z^2)
  |   * x^0 => ((1*z^2))
  |= ((1*z^2))
  |= ((1*z^2)*x + (1*z^2))
|   canonical coeff: ((1*z^2)*x + (1*z^2))
|   * y^3 => (((1*z^2)*y^3)*x + ((1*z^2)*y^3))
|= (((1*z^2)*y^3)*x + ((1*z^2)*y^3))
--- end canonicalize y-poly => (((1*z^2)*y^3)*x + ((1*z^2)*y^3)) ---
result: (((1*z^2)*y^3)*x + ((1*z^2)*y^3))
```

Canonicalizing the polynomial at construction time reduces the amount of work that needs to be done when performing operations. Since we know that our input polynomials are already in canonical form, all we have to do when adding/multiplying 2 polynomials of different variables is just convert the lower priority one to a 0th order polynomial in the higher priority one — there's no longer a need to recursively descend down the polynomial when performing the operation.

A tradeoff with this implementation is that there's a lot of redundant steps during the canonicalization process. Each time a polynomial is created, we can't avoid the descent down the nested polynomials although they've already been canonicalized.

Now, let's analyze the orders of growth for steps and space for `make-canonical`.

**Case 1: Polynomials with numerical coefficients**

When we call `add-poly` at each step, we:

- add the 1st term to the empty result list (1 step)
- add the 2nd term to the the 1-term result list (2 steps)
- ...
- add the *n*th term to the (*n*-1)-term result list (*n* steps)

This results in:

```
1 + 2 + ... + n = n(n+1)/2
```

steps in total. We won't have to consider the steps for multiplying polynomials in this case because the coefficients are always numbers. This means that we have an order of growth of steps of *O(n²)*.

In this process, we have a chain of *n* deferred `add-poly` operations. And within `add-terms`, we have a maximum of *n* deferred `adjoin-term` operations (when there's only 1 `add-poly` operation left). So, the order of growth for space is *O(n)*.

**Case 2: Polynomials with polynomial coefficients**

Let's say that we have a polynomial in `y` with coefficients that are polynomials in `x`. The process that takes place when we arrive at a term and canonicalize the coefficient is the same as **Case 1**. Let's say that the size of each coefficient polynomial is *m*. To canonicalize each coefficient, `m⋅(m+1)/2` steps are required. We have *n* coefficients, so `n⋅m⋅(m+1)/2` steps in total just to canonicalize the coefficients. 

We also have to perform `mul-poly` to multiply the coefficient with the variable. The `y` terms are converted into a polynomial of order `x⁰` to multiply with the coefficients. Each multiplication of the single `y`-term polynomial and its coefficient leads to *m* steps, since the `x` polynomial has *m* terms. So, we end up with a total of `n⋅m` steps for the multiplication of the canonicalized coefficients with the variable term.

In the addition process, we end up with *n* terms, each of which are `x` polynomials with *m* terms. Each of the coefficients in the `x` polynomials is a `y` polynomial with a single term. When we add the first couple of innermost `x` poly terms, we end up with:

- a maximum of *m* adjoins (if the orders of each of the `x` terms is the same), 
- and *m* adds of the coefficients, which leads to a maximum of 2 adjoins per add (if the orders of the `y` coefficients aren't the same). 

So, we have a total of 3*m* adjoin operations. 

**Note:** Below is an example of why we'd need 2 adjoins when adding the coefficients.

2yx^2 + 3y^2x^2 = (2y + 3y^2)x^2

Our worst-case scenario now is that our result has an *m*-term `x`-poly, with each coefficient being a 2-term `y`-poly. This leads to *m* adjoins and *m* adds of the coefficients, which leads to 3 adjoins per add. So, we have a total of 4*m* adjoin operations.

```
3m + 4m + ... + (n+1)m = m × ((n+1)(n+2)/2 - 3)
```

If we add up the total number of steps, we get an order of growth of steps of *O(mn² + nm²)*.

In this process, we'll have *n*-1 deferred `add-poly` operations, and the innermost `add-poly` leads to *m* adjoins and one add of the `y`-coeff poly's, which resolves to 2 adjoins. So, we have a total `n-1+m+2 = n+m+1` deferred operations, thus giving us an order of growth of space of *O(m + n)*.

|                                                            | Steps          | Space      |
| ---------------------------------------------------------  | -------------- | ---------- |
| **Case 1**: *n* terms, numerical coefficients              | *O(n²)*        | *O(n)*     |
| **Case 2**: *n* terms, polynomial coefficients of size *m* | *O(mn² + nm²)* | *O(m + n)* |

My parting notes for this exercise is that it reminded me a lot of the kind of problems you'd run into when doing TDD. You're figuring out the entities/concepts that exist in a domain and how they relate to each other, and sometimes, they're not straightforward. A lot of the work that we did in this exercise was plumbing around the types — adding special clauses for number-polynomial operations, coercing polynomials defined in one variable to another, etc.
