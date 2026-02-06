---
slug: exercise-1-20
name: Exercise 1.20
date: 26-02-02 14:25
---

The process that a procedure generates is of course dependent on the rules used by the interpreter. As an example, consider the iterative gcd procedure given above. Suppose we were to interpret this procedure using normal-order evaluation, as discussed in Section 1.1.5. (The normal-order-evaluation rule for `if` is described in [Exercise 1.5](/exercise-1.5).) Using the substitution method (for normal order), illustrate the process generated in evaluating `(gcd 206 40)` and indicate the `remainder` operations that are actually performed. How many `remainder` operations are actually performed in the normal-order evaluation of `(gcd 206 40)`? In the applicative-order evaluation?

## Solution

**normal-order evaluation**: fully expand until you're only left with primitive operators, and then reduce

**applicative-order evaluation**: evaluate the arguments and then apply the operation indicated by the procedure

The evaluation rule for the special form `if` is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.

**Note:** `remainder` is a primitive.

```racket
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

This is the process followed by the normal-order evaluation of `(gcd 206 40)`:

```racket
(gcd 206 40)

(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))

(if (= (remainder 206 40) 0)
    40
    (gcd (remainder 206 40)
         (remainder 40 (remainder 206 40))))

(if (= 6 0)
    40
    (gcd (remainder 206 40)
         (remainder 40 (remainder 206 40))))

; remainder operations count: 1

(gcd (remainder 206 40)
     (remainder 40 (remainder 206 40)))

(if (= (remainder 40 (remainder 206 40)) 0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40) 
                    (remainder 40 (remainder 206 40)))))

(if (= (remainder 40 6) 0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40) 
                    (remainder 40 (remainder 206 40)))))

; remainder operations count: 2

(if (= 4 0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40) 
                    (remainder 40 (remainder 206 40)))))

; remainder operations count: 3

(gcd (remainder 40 (remainder 206 40))
     (remainder (remainder 206 40) 
                (remainder 40 (remainder 206 40))))

(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40) 
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))))

(if (= (remainder (remainder 206 40) (remainder 40 6)) 0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40) 
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))))

; remainder operations count: 4

(if (= (remainder (remainder 206 40) 4) 0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40) 
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))))

; remainder operations count: 5

(if (= (remainder 6 4) 0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40) 
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))))

; remainder operations count: 6

(if (= 2 0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40) 
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))))

; remainder operations count: 7

(gcd (remainder (remainder 206 40) 
                (remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40) 
                           (remainder 40 (remainder 206 40)))))

(if (= (remainder (remainder 40 (remainder 206 40)) 
                  (remainder (remainder 206 40) 
                             (remainder 40 (remainder 206 40)))) 
       0)
    (remainder (remainder 206 40) 
               (remainder 40 (remainder 206 40)))
    (gcd (remainder (remainder 40 (remainder 206 40)) 
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))
         (remainder (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40)))
                    (remainder (remainder 40 (remainder 206 40))
                               (remainder (remainder 206 40) 
                                          (remainder 40 (remainder 206 40)))))))

(if (= (remainder (remainder 40 (remainder 206 40)) 
                  (remainder (remainder 206 40) 
                             4)) 
       0)
    (remainder (remainder 206 40) 
               (remainder 40 (remainder 206 40)))
    (gcd (remainder (remainder 40 (remainder 206 40)) 
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))
         (remainder (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40)))
                    (remainder (remainder 40 (remainder 206 40))
                               (remainder (remainder 206 40) 
                                          (remainder 40 (remainder 206 40)))))))

; remainder operations count: 9

(if (= (remainder (remainder 40 (remainder 206 40)) 
                  2) 
       0)
    (remainder (remainder 206 40) 
               (remainder 40 (remainder 206 40)))
    (gcd (remainder (remainder 40 (remainder 206 40)) 
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))
         (remainder (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40)))
                    (remainder (remainder 40 (remainder 206 40))
                               (remainder (remainder 206 40) 
                                          (remainder 40 (remainder 206 40)))))))

; remainder operations count: 11

(if (= 0 0)
    (remainder (remainder 206 40) 
               (remainder 40 (remainder 206 40)))
    (gcd (remainder (remainder 40 (remainder 206 40)) 
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))
         (remainder (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40)))
                    (remainder (remainder 40 (remainder 206 40))
                               (remainder (remainder 206 40) 
                                          (remainder 40 (remainder 206 40)))))))

; remainder operations count: 14

(remainder (remainder 206 40) 
           (remainder 40 (remainder 206 40)))

(remainder (remainder 206 40) 
           (remainder 40 6))

; remainder operations count: 15

(remainder 6 4)

; remainder operations count: 17

2

; remainder operations count: 18
```

18 `remainder` operations are performed in the normal-order evaluation of `(gcd 206 40)`.

This is the process followed by the applicative-order evaluation of `(gcd 206 40)`:

```racket
(gcd 206 40)

(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))
(gcd 40 6) ; remainder operations count: 1

(if (= 6 0)
    40
    (gcd 6 (remainder 40 6)))

(gcd 6 (remainder 40 6))
(gcd 6 4) ; remainder operations count: 2

(if (= 4 0)
    6
    (gcd 4 (remainder 6 4)))

(gcd 4 (remainder 6 4))
(gcd 4 2) ; remainder operations count: 3

(if (= 2 0)
    4
    (gcd 2 (remainder 4 2)))

(gcd 2 (remainder 4 2))
(gcd 2 0) ; remainder operations count: 4

(if (= 0 0)
    2
    (gcd 0 (remainder 2 0)))

2
```

4 `remainder` operations are performed in the applicative-order evaluation of `(gcd 206 40)`.
