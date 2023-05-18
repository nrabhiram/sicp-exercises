# Exercise 1.4

Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

```scheme
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

# Solution

If b is a positive number, the result will be `a + b`.
Otherwise, the result will be `a - b`.
The function computes `a + |b|`