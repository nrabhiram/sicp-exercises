---
slug: exercise-2-73
name: Exercise 2.73
date: 26-05-26 12:47
---

Section 2.3.2 described a program that performs symbolic differentiation:

```racket
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum (make-product
                    (multiplier exp)
                    (deriv (multiplicand exp) var))
                   (make-product
                    (deriv (multiplier exp) var)
                    (multiplicand exp))))
        ⟨more rules can be added here⟩
        (else (error "unknown expression type:
                     DERIV" exp))))
```

We can regard this program as performing a dispatch on the type of the expression to be differentiated. In this situation the “type tag” of the datum is the algebraic operator symbol (such as `+`) and the operation being performed is `deriv`. We can transform this program into data-directed style by rewriting the basic derivative procedure as

```racket
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
```

a. Explain what was done above. Why can’t we assimilate the predicates `number?` and `variable?` into the data-directed dispatch?
b. Write the procedures for derivatives of sums and products, and the auxiliary code required to install them in the table used by the program above.
c. Choose any additional differentiation rule that you like, such as the one for exponents ([Exercise 2.56](/exercise-2-56)), and install it in this data-directed system.
d. In this simple algebraic manipulator the type of an expression is the algebraic operator that binds it together. Suppose, however, we indexed the procedures in the opposite way, so that the dispatch line in deriv looked like

```racket
((get (operator exp) 'deriv) (operands exp) var) 
```

What corresponding changes to the derivative system are required?

## Solution

We have created a table with:

- a vertical axis which gives us the operation we want to perform on an expression
- a horizontal axis which gives us the type of the expression

We obtain the expression's type by examining the symbol used for the operator of the expression. Ex. `+` or `*`.

We can't add numbers and variables to the data-directed dispatch although they're expressions because they're not compound expressions, and hence, not represented using lists that contain a tag to identify the type of the expression. When we call `operator` on a number/variable, since it's not a list, it leads to an error, because `car` can't be applied. That is why they're treated as special cases.

If we indexed procedures in the opposite way, the corresponding changes to the system that are required will be to swap the indices in the `put` operations specified in the package installation procedures for each kind of expression.

```racket
(put '+ 'deriv deriv-sum)
(put '* 'deriv deriv-product)
(put '** 'deriv deriv-exponentation)
```
