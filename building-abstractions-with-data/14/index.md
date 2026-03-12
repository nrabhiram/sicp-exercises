---
slug: exercise-2-14
name: Exercise 2.14
date: 26-03-12 11:23
---

Demonstrate that Lem is right. Investigate the behavior of the system on a variety of arithmetic expressions. Make some intervals *A* and *B*, and use them in computing the expressions *A/A* and *A/B*. You will get the most insight by using intervals whose width is a small percentage of the center value. Examine the results of the computation in `center-percent` form (see [Exercise 2.12](exercise-2-12)).

## Solution

Lem E. Tweakit is right. If we apply the 2 formulas on the same intervals to calculate the parallel resistance, we notice that the tolerance values deviate significantly, but the bounds for the parallel resistance calculated by the second formula are a lot tighter.

| R1              | R2              | par1             | par2             |
|-----------------|-----------------|------------------|------------------|
| 100.0 ± 8.0%    | 200.0 ± 5.0%    | 67.70 ± 18.80%   | 66.65 ± 7.00%    |
| 100.0 ± 5.0%    | 100.0 ± 5.0%    | 50.50 ± 14.90%   | 50.00 ± 5.00%    |
| 100.0 ± 0.1%    | 200.0 ± 0.1%    | 66.67 ± 0.30%    | 66.67 ± 0.10%    |
| 100.0 ± 20.0%   | 200.0 ± 15.0%   | 74.63 ± 47.93%   | 66.63 ± 18.35%   |
| 50.0 ± 3.0%     | 500.0 ± 10.0%   | 46.55 ± 22.06%   | 45.44 ± 3.64%    |

For *A/A* and *A/B*, the tolerance of the result is approximately the sum of the tolerances of the operands. Ideally, *A/A* should be `1 ± 0%`. But, there isn't a way to identify that the numerator and denominator values are the same. Although the underlying intervals used for these values are of the same range, we can't assume that the intervals are identical. Since they're considered to be separate values, the tolerance nearly doubles.
| A               | B              | A/A              | A/B              |
|-----------------|----------------|------------------|------------------|
| 10.0 ± 0.20%    | 5.0 ± 0.10%    | 1.00 ± 0.40%     | 2.00 ± 0.30%     |
| 100.0 ± 5.0%    | 200.0 ± 3.0%   | 1.01 ± 9.98%     | 0.50 ± 7.99%     |
| 50.0 ± 10.0%    | 50.0 ± 10.0%   | 1.02 ± 19.80%    | 1.02 ± 19.80%    |

This is known as the **dependency problem**. When the same interval appears multiple times in an expression, we do not have a way to identify that this is the same value being repeated. We assume that these are distinct intervals, and this causes the tolerance to be inflated.
