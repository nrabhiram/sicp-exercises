---
slug: exercise-2-86
name: Exercise 2.86
date: 11-06-26 21:05
---

Suppose we want to handle complex numbers whose real parts, imaginary parts, magnitudes, and angles can be either ordinary numbers, rational numbers, or other numbers we might wish to add to the system. Describe and implement the changes to the system needed to accommodate this. You will have to define operations such as `sine` and `cosine` that are generic over ordinary numbers and rational numbers.

## Solution

The operations `sine`, `cosine`, `arctan`, `square`, and `square-root` need to be made generic over ordinary numbers (integers and real), and rational numbers. Note that the results of these operations return real numbers because that's the highest type in the hierarchy that can satisfy all of the possible values returned by these operations.

The constructor procedure in the real numbers package needs to accept both ordinary numbers and rational numbers because complex numbers project to real numbers in our arithmetic system, and the components of a complex number, such as the real part, can be of any type (integer, rational, or real). So, when we reduce a complex number to a real one, `make-real` should be able to raise the real part of the complex number until it's a real number. 

Unfortunately, this means that the real number package has to hold knowledge about the latent structure of the system, either explicitly or implicitly. We can do it implicitly because we know that the permissible values for the real part of a complex number can be anything below complex numbers in the hierarchy of types.

**Note:** This doesn't cause an immediate problem, but we tag the arguments passed to `make-complex-from-real-imag` in the raise operation for real numbers. Technically, the system would still work even if we didn't do this, but for consistency, it's better to tag them as real numbers.
