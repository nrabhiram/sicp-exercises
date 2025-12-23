# Exercise 1.41

Define a procedure `double` that takes a procedure of one argument as argument and returns a procedure that applies the original procedure twice. For example, if `inc` is a procedure that adds `1` to its argument, then `(double inc)` should be a procedure that adds 2. What value is returned by

```scheme
(((double (double double)) inc) 5)
```

# Solution

```
(double double) -> (lambda (x) (double (double x))) -> (g x)
(double (double double)) -> (lambda (x) (double (double (double (double x))))) -> (g (g x))
((double (double double)) inc) -> (double (double (double (double inc))))
Leads to a procedure that applies inc 16 times
```

So, the value returned is `21`.