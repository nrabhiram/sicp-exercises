---
slug: exercise-2-9
name: Exercise 2.9
date: 26-03-10 10:01
---

The *width* of an interval is half of the difference between its upper and lower bounds. The width is a measure of the uncertainty of the number specified by the interval. For some arithmetic operations the width of the result of combining two intervals is a function only of the widths of the argument intervals, whereas for others the width of the combination is not a function of the widths of the argument intervals. Show that the width of the sum (or difference) of two intervals is a function only of the widths of the intervals being added (or subtracted). Give examples to show that this is not true for multiplication or division.

## Solution

Let's say that we have 2 intervals on which we'll perform operations such as addition, subtraction, multiplication, and division.

```
2x(width) = x(upper) - x(lower)
2y(width) = y(upper) - y(lower)
```

Let's examine the case of addition:

```
z = x + y

z(lower) = x(lower) + y(lower)
z(upper) = x(upper) + y(upper)

2z(width) = z(upper) - z(lower)
          = x(upper) + y(upper) - x(lower) - y(lower)
          = x(upper) - x(lower) + y(upper) - y(lower)
          = 2x(width) + 2y(width)
          
z(width) = x(width) + y(width)
```

In the case of subtraction:

```
z = x - y

z(lower) = x(lower) - y(upper)
z(upper) = x(upper) - y(lower)

2z(width) = z(upper) - z(lower)
          = x(upper) - y(lower) - x(lower) + y(upper)
          = x(upper) - x(lower) + y(upper) - y(lower)
          = 2x(width) + 2y(width)
          
z(width) = x(width) + y(width)
```

Division is just a special case of multiplication. Let's consider an example in which the endpoints of both the intervals are > 0.

```
z = x * y

z(lower) = x(lower) * y(lower)
z(upper) = x(upper) * y(upper)

2z(width) = z(upper) - z(lower)
          = x(upper) * y(upper) - x(lower) * y(lower)
```

The resultant width can't be expressed in terms of the widths of the intervals that are being operated.
