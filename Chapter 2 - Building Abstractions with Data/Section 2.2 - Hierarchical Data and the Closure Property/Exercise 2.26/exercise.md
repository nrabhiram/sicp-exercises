# Exercise 2.26

Suppose we define `x` and `y` to be two lists:

```scheme
(define x (list 1 2 3))
(define y (list 4 5 6))
```

What result is printed by the interpreter in response to evaluating each of the following expressions:

```scheme
(append x y)
(cons x y)
(list x y)
```

# Solution

The results printed by the interpreter are as follows:

```
(1 2 3 4 5 6)
((1 2 3) 4 5 6)
((1 2 3) (4 5 6))
```