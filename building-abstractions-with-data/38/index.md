---
slug: exercise-2-38
name: Exercise 2.38
date: 26-03-31 17:54
---

The `accumulate` procedure is also known as `fold-right`, because it combines the first element of the sequence with the result of combining all the elements to the right. There is also a `fold-left`, which is similar to `fold-right`, except that it combines elements working in the opposite direction:

```racket
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))
```

What are the values of

```racket
(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list nil (list 1 2 3))
(fold-left list nil (list 1 2 3))
```

Give a property that `op` should satisfy to guarantee that `fold-right` and `fold-left` will produce the same values for any sequence.

## Solution

The names of the procedures confused me because it felt like they didn't make sense. Here's a visualization trick that helped:

- In `fold-right`, the nesting of parentheses, i.e. the innermost call is on the right, starting from the last element, and the result builds up from there.
- In `fold-left`, the nesting of parentheses, i.e. the innermost call is on the left, starting from the first element, and the result builds up from there.

Another way to visualize this is:

- In `fold-right`, the accumulated result is the right argument.
- In `fold-left`, the accumulated result is the left argument.

Here's an example:

```racket
(fold-right + 0 (list 1 2 3))
(+ 1 (+ 2 (+ 3 0)))
(+ 1 (+ 2 3))
(+ 1 5)
6

(fold-left + 0 (list 1 2 3))
(+ (+ (+ 0 1) 2) 3)
(+ (+ 1 2) 3)
(+ 3 3)
6
```

Here's the evaluation process for the expressions provided in the question.

```racket
(fold-right / 1 (list 1 2 3))
(/ 1 (/ 2 (/ 3 1)))
(/ 1 (/ 2 3))
(/ 1 2/3)
3/2

(fold-left / 1 (list 1 2 3))
(/ (/ (/ 1 1) 2) 3)
(/ (/ 1 2) 3)
(/ 1/2 3)
1/6

(fold-right list nil (list 1 2 3))
(list 1 (list 2 (list 3 nil)))
(1 (2 (3 ())))

(fold-left list nil (list 1 2 3))
(list (list (list nil 1) 2) 3)
(((() 1) 2) 3)
```

The property that `op` should satisfy to to guarantee that `fold-right` and `fold-left` will produce the same values for any sequence is that **it should be communicative**. `(op a b)` and `(op b a)` should produce the same result. `+` satisfies this condition, but `/` and `list` do not.
