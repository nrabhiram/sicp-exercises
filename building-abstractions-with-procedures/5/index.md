---
slug: exercise-1-5
name: Execrise 1.5
date: 23-12-25 08:42
---

Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

```racket
(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))
```

Then he evaluates the expression

```racket
(test 0 (p))
```

What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he
observe with an interpreter that uses normal-order evaluation? Explain your answer. (Assume that the evaluation rule for the special form `if` is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.)

## Solution

If the interpreter uses applicative-order evaluation, all of the sub-expressions of the combination are evaluated, and the procedure denoted by the operator is applied to the operands. When `p` is evaluated, the value it yields is itself. We're put in a never-ending loop, because `p` can't be evaluated further.

If the interpreter uses normal-order evaluation, the values of the operands aren't evaluated, and are substituted as parameters for procedure application as is, until we reach a point where the expression comprises only primitive procedures.

```racket
(test 0 (p))
(if (= 0 0) 0 (p)))
0
```

In this expansion, the alternative never gets evaluated because the predicate evaluates to a true value. So, the result in this case is `0`.
