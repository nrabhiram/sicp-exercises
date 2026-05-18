---
slug: exercise-2-70
name: Exercise 2.70
date: 26-05-18 23:53
---

The following eight-symbol alphabet with associated relative frequencies was designed to efficiently encode the lyrics of 1950s rock songs. (Note that the “symbols” of an “alphabet” need not be individual letters.)

```
A 2      GET 2   SHA 3   WAH 1
BOOM 1   JOB 2   NA 16   YIP 9
```

Use `generate-huffman-tree` ([Exercise 2.69](/exercise-2-69)) to generate a corresponding Huffman tree, and use `encode` ([Exercise 2.68](/exercise-2-70)) to encode the following message:

```
Get a job
Sha na na na na na na na na
Get a job
Sha na na na na na na na na
Wah yip yip yip yip yip yip yip yip yip
Sha boom
```

How many bits are required for the encoding? What is the smallest number of bits that would be needed to encode this song if we used a fixed-length code for the eight-symbol alphabet?

## Solution

The number of bits required for the encoding of the message is **84**. If we used fixed-length encoding for the alphabet, we'd need to use `log₂8 = 3` bits for each symbol. Since the length of the message is 36, we'd need a total of `36 × 3 = 108` bits to encode it.
