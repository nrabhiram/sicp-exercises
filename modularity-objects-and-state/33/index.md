---
slug: exercise-3-33
name: Exercise 3.33
date: 15-09-26 23:46
---

Using primitive multiplier, adder, and constant constraints, define a procedure `averager` that takes three connectors `a`, `b`, and `c` as inputs and establishes the constraint that the value of `c` is the average of the values of `a` and `b`.

## Solution

I'm noting this down, because it seems like the following set of exercises demand familiarity with the constraint propagation system we just created. For the following sequence of operations performed:

```racket
(define a (make-connector))
(define b (make-connector))
(define c (make-connector))
(probe "a" a)
(probe "b" b)
(probe "c" c)

(averager a b c)
(set-value! a 5 'user)
(set-value! b 7 'user)
(forget-value! a 'user)
(forget-value! b 'user)
```

This is the sequence of messages that is printed:

```
Probe: a = 5
done
Probe: c = 6
Probe: b = 7
done
Probe: c = ?
Probe: a = ?
done
Probe: b = ?
done
```

When we first set the value of `a`, we don't have enough information yet to set either `b` or `s`. But, after setting the value of `b` to 7, we do. Now, the `adder` constraint sets the value of `s` to 12, and the value is propagated to the `multiplier` constraint. Since the value of the connector connected to the `constant` is set, and we have the value of the product, the other multiplicand can be set.

The reason for `c`'s probe getting pinged before `b` is that `b` first informs the `adder` of its value and then the `probe`. So after the value has been fully propagated, and `c` has been set, does the `probe` react to the change in value for `b`.

The logic in this explanation can be recycled for the order of probe reports when the `user` forgets the value of `a`. The value of `s` was originally set by the `adder`. So, when it tries to forget the value of `s`, it succeeds. And this is informed to the `multiplier`. Note that the value of `b` isn't forgotten yet, because it was set by the `user`, so the `adder` can't forget it.
