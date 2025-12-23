# Exercise 2.9

The width of an interval is half of the difference between its upper and lower bounds. The width is a measure of the uncertainty of the number specified by the interval. For some arithmetic operations the width of the result of combining two intervals is a function only of the widths of the argument intervals, whereas for others the width of the combination is not a function of the widths of the argument intervals. Show that the width of the sum (or difference) of two intervals is a function only of the widths of the intervals being added (or subtracted). Give examples to show that this is not true for multiplication or division.

# Solution

The width of an interval can be expressed as shown:

```
2x(width) = x(upper) - x(lower)
2y(width) = y(lower) - y(lower)
```

In the case of addition, the width of the resultant interval can be calculated as shown:

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

In the case of subtraction, the width of the resultant interval can be calculated as shown:

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

Notice that width of the sum or difference of two intervals is a function of the widths of the argument intervals.

Let us consider a case of multiplication, if all number are > 1,

```
z = x * y
z(lower) = x(lower) * y(lower)
z(upper) = x(upper) * y(upper)
2z(width) = z(upper) - z(upper)
          = x(upper) * y(upper) - x(lower) * y(lower)
```

Notice that this isn't the case for the multiplication or division of two intervals.