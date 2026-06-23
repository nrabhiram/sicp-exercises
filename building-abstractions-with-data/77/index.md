---
slug: exercise-2-77
name: Exercise 2.77
date: 31-05-26 14:10
---

Louis Reasoner tries to evaluate the expression `(magnitude z)` where `z` is the object shown in Figure 2.24. To his surprise, instead of the answer 5 he gets an error message from `apply-generic`, saying there is no method for the operation `magnitude` on the types `(complex)`. He shows this interaction to Alyssa P. Hacker, who says “The problem is that the complex-number selectors were never defined for `complex` numbers, just for `polar` and `rectangular` numbers. All you have to do to make this work is add the following to the complex package:”

```racket
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)
```

Describe in detail why this works. As an example, trace through all the procedures called in evaluating the expression `(magnitude z)` where `z` is the object shown in Figure 2.24. In particular, how many times is `apply-generic` invoked? What procedure is dispatched to in each case?

## Solution

```racket
(magnitude z)
(apply-generic 'magnitude 
               (cons 'complex (cons 'rectangular (cons 3 4))))
((get 'magnitude '(complex)) (cons 'rectangular (cons 3 4)))
(magnitude (cons 'rectangular (cons 3 4)))
(apply-generic 'magnitude (cons 'rectangular (cons 3 4)))
((get 'magnitude '(rectangular)) (cons 3 4))
(sqrt (+ (square 3)
         (square 4)))
(sqrt 25)
5
```

In the evaluation of the expression `(magnitude z)`, `apply-generic` is invoked twice. The first time, it dispatches to the generic interface procedure `magnitude`. The `complex` type tag is stripped from the datum and used to index the operation procedure from the table, which points to `magnitude`. The type tag of the datum points to `rectangular` now. So, when `apply-generic` is called again, the operation procedure that is indexed is the `magnitude` procedure defined internal to the rectangular package.

When `apply-generic` is called the first, time because the `put` operation points to the generic `magnitude` procedure for `magnitude` of `complex` numbers, it strips the `complex` type tag to expose the `rectangular` type tag, and calls `magnitude` on it again, which applies the representation's internal `magnitude` operation.
