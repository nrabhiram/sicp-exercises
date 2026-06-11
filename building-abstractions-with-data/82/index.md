---
slug: exercise-2-82
name: Exercise 2.82
date: 27-06-06 16:56
---

Show how to generalize `apply-generic` to handle coercion in the general case of multiple arguments. One strategy is to attempt to coerce all the arguments to the type of the first argument, then to the type of the second argument, and so on. Give an example of a situation where this strategy (and likewise the two-argument version given above) is not sufficiently general. (Hint: Consider the case where there are some suitable mixed-type operations present in the table that will not be tried.)

## Solution

Let's say that there's an operation that cuts across unrelated types. Ex. You want to define a `scale` operation that takes a `scheme-number` and `complex` and multiplies the real and imaginary parts. The implementation of `apply-generic` in this exercise and the previous one, we assume that the operation will always be defined for arguments of the same type. But, in this case, we'll be performing the wrong operation by coercing the types. Ex. We'll be trying to operate on `(complex complex)` instead of `(scheme-number complex)`, which is an invalid operation in this case.
