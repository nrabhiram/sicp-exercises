# Exercise 1.5

Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

```scheme
(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))
```

Then he evaluates the expression

```scheme
(test 0 (p))
```

What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer. Assume that the evaluation rule for the special form `if` is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.

# Solution

## Applicative-Order

In applicative-order-evaluation, the subexpressions of the combination are evaluated. Then, the procedure is applied to the arguments.

**Note**: This kind of evaluation process is recursive, i.e. the rule includes as one of its steps, the need to invoke the rule itself.

```scheme
(define (p) (p))
```

The expresison `p` evaluates to itself.

```scheme
(test 0 (p))
```

If the interpreter uses applicative-order-evaluation, the subexpressions `test`, `0`, and `p` are evaluated. But, since `p` evaluates to itself, its evaluation starts over and over again, thus causing an **infinite loop**.

## Normal-Order

In normal-order-evaluation, we wouldn't evaluate operands until their values were needed. The operand expressions are substituted for parameters until an expression is obtained involving only primitive expressions. Then, the evaluation is performed.

If the interpreter uses normal-order-evaluation, it *fully expands and then reduces* the expression. So, the operands aren't evaluated until their values are required, i.e. when the expression has been fully expanded.

```scheme
test (0 (p))

(if (= 0 0)
  0
  (p))
```

The alternative isn't evaluated since the predicate is `true` (specifically `#t`).