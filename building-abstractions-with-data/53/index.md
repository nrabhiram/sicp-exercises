---
slug: exercise-2-53
name: Exercise 2.53
date: 26-04-24 14:24
---

What would the interpreter print in response to evaluating each of the following expressions?

```racket
(list 'a 'b 'c)
(list (list 'george))
(cdr '((x1 x2) (y1 y2)))
(cadr '((x1 x2) (y1 y2)))
(pair? (car '(a short list)))
(memq 'red '((red shoes) (blue socks)))
(memq 'red '(red shoes blue socks))
```

## Solution

```racket
(a b c)
((george))
((y1 y2))
(y1 y2)
#f
#f
(red shoes blue socks)
```
