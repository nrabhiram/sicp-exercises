# Exercise 2.22

Louis Reasoner tries to rewrite the first `square-list` procedure of Exercise 2.21 so that it evolves an iterative process:

```scheme
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))
```

Unfortunately, defining `square-list` this way produces the answer list in the reverse order of the one desired. Why?

Louis then tries to fix his bug by interchanging the arguments to `cons`:

```scheme
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))
```

This doesn’t work either. Explain.

# Solution

In the first attempt, the list is iteratively being constructed from the opposite end. Ex. If we have a list of 4 elements, 

- the 1st element is added as the 4th element of the new list,
- the 2nd element is added as the 3rd element,
- and so on ...

In the second attempt, we construct a structure that isn't a list, i.e. each element has to be accessed using `cdr` instead of `car`.

```
# 1st iteration
(list 2 3 4)
(cons nil 1)

# 2nd iteration
(list 3 4)
(cons (cons nil 1)
      4)

# 3rd iteration
(list 4)
(cons (cons (cons nil 1)
             4)
       9)

# 4th iteration
nil
(cons (cons (cons (cons nil 1)
                  4)
            9)
      16)
```

So, for examlple if we have a list, `(list 1 2 3 4)`, we create the structure shown above, and each element is accessed as shown:

- the first element in the list is accessed using `(cdr list)`,
- the second element in the list is accessed using `(cdr (car list))`,
- and so on ...

Additionally, the elements in this structure are also in the reverse order.