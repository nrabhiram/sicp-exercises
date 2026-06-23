---
slug: exercise-2-81
name: Exercise 2.81
date: 06-06-26 14:31
---

Louis Reasoner has noticed that `apply-generic` may try to coerce the arguments to each other’s type even if they already have the same type. Therefore, he reasons, we need to put procedures in the coercion table to *coerce* arguments of each type to their own type. For example, in addition to the `scheme-number->complex` coercion shown above, he would do:

```racket
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(put-coercion 'scheme-number
              'scheme-number
              scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)
```

a. With Louis’s coercion procedures installed, what happens if `apply-generic` is called with two arguments of type `scheme-number` or two arguments of type `complex` for an operation that is not found in the table for those types? For example, assume that we’ve defined a generic exponentiation operation:

```racket
(define (exp x y) (apply-generic 'exp x y))
```

and have put a procedure for exponentiation in the Scheme-number package but not in any other package:

```racket
;; following added to Scheme-number package
(put 'exp '(scheme-number scheme-number)
  (lambda (x y) (tag (expt x y))))
  ; using primitive expt
```

What happens if we call `exp` with two complex numbers as arguments?

b. Is Louis correct that something had to be done about coercion with arguments of the same type, or does `apply-generic` work correctly as is?

c. Modify `apply-generic` so that it doesn’t try coercion if the two arguments have the same type.

## Solution

Let's say that we call `apply-generic` with two arguments of the same type for an operation that has not been defined for these types. Ex. `(complex complex)`. `proc` isn't found in the table, so it returns `#f`. This means that the else clause is evaluated, where we'll either:

- try to coerce one of the types to the other by checking if the corresponding procedures exist in the coercion table, and call `apply-generic` with the object that has been coerced to the type of the other object
- or signal that the operation doesn't exist for these types with an error

Now, if we add procedures in the coercion table to coerce arguments of each type to their own type, and an operation doesn't exist for these types, we end up in an infinite loop.

So, Louis is incorrect that something had to be done about coercion with arguments of the same type. `apply-generic` works correctly as is, without introducing same-type coercion procedures.

If we don't want `apply-generic` to try coercion if two arguments have the same type, we need to add it as the first clause in the `cond` so that it signals an error that the operation hasn't been defined for this combination of types. This will ensure that `apply-generic` works as intended, regardless of whether coercion procedures to convert an object of one type to the same type exist or not.
