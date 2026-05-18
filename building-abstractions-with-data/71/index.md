---
slug: exercise-2-71
name: Exercise 2.71
date: 26-05-19 00:51
---

Suppose we have a Huffman tree for an alphabet of *n* symbols, and that the relative frequencies of the symbols are 1, 2, 4,...,2*ⁿ*⁻¹. Sketch the tree for *n* = 5; for *n* = 10. In such a tree (for general *n*) how many bits are required to encode the most frequent symbol? The least frequent symbol?

## Solution

For *n* = 5, with symbols a→1, b→2, c→4, d→8, e→16:

```
                {a,b,c,d,e} 31
                /            \
              0/              \1
              /                \
           e 16          {a,b,c,d} 15
                          /        \
                        0/          \1
                        /            \
                      d 8        {a,b,c} 7
                                  /      \
                                0/        \1
                                /          \
                              c 4        {a,b} 3
                                          /    \
                                        0/      \1
                                        /        \
                                      a 1        b 2
```

For *n* = 10, with symbols a→1, b→2, c→4, d→8, e→16, f→32, g→64, h→128, i→256, j→512:

```
  {a,b,c,d,e,f,g,h,i,j} 1023
  /                      \
0/                        \1
/                          \
j 512              {a,b,c,d,e,f,g,h,i} 511
                    /                    \
                  0/                      \1
                  /                        \
               i 256            {a,b,c,d,e,f,g,h} 255
                                 /                  \
                               0/                    \1
                               /                      \
                            h 128          {a,b,c,d,e,f,g} 127
                                            /              \
                                          0/                \1
                                          /                  \
                                       g 64          {a,b,c,d,e,f} 63
                                                      /            \
                                                    0/              \1
                                                    /                \
                                                 f 32          {a,b,c,d,e} 31
                                                                /          \
                                                              0/            \1
                                                              /              \
                                                           e 16        {a,b,c,d} 15
                                                                        /        \
                                                                      0/          \1
                                                                      /            \
                                                                   d 8        {a,b,c} 7
                                                                                /      \
                                                                              0/        \1
                                                                              /          \
                                                                           c 4        {a,b} 3
                                                                                       /    \
                                                                                     0/      \1
                                                                                     /        \
                                                                                   a 1        b 2
```

Notice that a pattern emerges for any value of *n*. At each merge step, the frequency of the bigger of the 2 nodes is always 1 greater than the frequency of the smaller node, which is the sum of frequencies of all of the symbols preceding it. This can be proven as shown below.

```
1 + 2 + 4 + ... + 2ⁿ⁻¹ = 2⁰ + 2¹ + 2² + ... + 2ⁿ⁻¹
                       = (2ⁿ - 1) / (2 - 1)
                       = 2ⁿ - 1
```

This leads to an unbalanced tree in which the leaf with the greatest frequency is always merged last and is placed at the top.

| *n* | Most frequent symbol | Code | Bits | Least frequent symbol | Code        | Bits |
|-----|----------------------|------|------|-----------------------|-------------|------|
| 5   | e (16)               | `0`  | 1    | a (1)                 | `1110`      | 4    |
| 10  | j (512)              | `0`  | 1    | a (1)                 | `111111110` | 9    |

In general:

- The **most frequent** symbol requires **1 bit** to encode.
- The **least frequent** symbol requires **n - 1 bits** to encode.
