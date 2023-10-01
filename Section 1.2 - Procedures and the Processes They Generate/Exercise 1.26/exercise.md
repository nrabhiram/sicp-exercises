# Exercise 1.26

Louis Reasoner is having great difficulty doing Exercise 1.24. His `fast-prime?` test seems to run more slowly than his `prime?`. Louis calls his friend Eva Lu Ator over to help. When they examine Louis’s code, they find that he has rewritten the `expmod` procedure to use an explicit multiplication, rather than calling `square`:

```scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base
                       (expmod base (- exp 1) m))
                    m))))
```

“I don’t see what difference that could make,” says Louis. “I do.” says Eva. “By writing the procedure like that, you have transformed the `Θ(logn)` process into a `Θ(n)` process.” Explain.

# Solution

Louis' version of `expmod` uses `*` instead of `square`. Since we follow **applicative-order evaluation**, the arguments are evaluated before applying the procedure. So, `(expmod base (/ exp 2) m)` is evaluated twice.

If we consider the case in which we use `square`, when the size of the exponential doubles, the number of steps increases by 1.

```
(square (expmod base n m)) --> a steps

(square (expmod base 2n m))
(square (square (expmod base n m))) --> (a + 1) steps
```

This implies an orgder of growth of `Θ(logn)`.

Whereas if we consider the case in which we use `*`, the number of steps is doubled whenever the size of the exponentional is doubled.

```
(* (expmod base n m)
   (expmod base n m)) --> a steps

(* (expmod base 2n m)
   (expmod base 2n m))

(* (* (expmod base n m) (expmod base n m))
   (* (expmod base n m) (expmod base n m))) --> 2a steps
```

∴ The new order of growth is `Θ(n)`.