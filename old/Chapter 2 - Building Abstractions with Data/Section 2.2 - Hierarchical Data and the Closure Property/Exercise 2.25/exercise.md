# Exercise 2.25

Give combinations of `car`s and `cdr`s that will pick `7` from each of the following lists:

```scheme
(1 3 (5 7) 9)
((7))
(1 (2 (3 (4 (5 (6 7))))))
```

# Solution

```scheme
(car (cdr (car (cdr (cdr x)))))
(car (car x))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr x))))))))))))
```