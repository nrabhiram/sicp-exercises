---
slug: exercise-3-32
name: Exercise 3.32
date: 11-09-26 14:45
---

The procedures to be run during each time segment of the agenda are kept in a queue. Thus, the procedures for each segment are called in the order in which they were added to the agenda (first in, first out). Explain why this order must be used. In particular, trace the behavior of an and-gate whose inputs change from 0, 1 to 1, 0 in the same segment and say how the behavior would differ if we stored a segment’s procedures in an ordinary list, adding and removing procedures only at the front (last in, first out).

## Solution

| time | a   | b   | note                                              |
| ---- | --- | --- | ------------------------------------------------- |
| 0    | 0   | 1   | stable starting state                             |
| 0    | 1   | 1   | schedules action after the and-gate delay (id: 1) |
| 0    | 1   | 0   | schedules action after the and-gate delay (id: 2) |

**Note:** We assume that when the inputs are 0, 1, all action procedures already in the agenda have been processed; that is, the circuit is stable.

If we use a queue, with a first in, first out mechanism, after the and-gate delay, this will be the sequence of signal values we'll see at the output.

| time  | output | action id |
| ----- | ------ | --------- |
| delay | 1      | 1         |
| delay | 0      | 2         |

If we use an ordinary list with a last in, first out mechanism, the sequence of signal values will be as shown:

| time  | output | action id |
| ----- | ------ | --------- |
| delay | 0      | 2         |
| delay | 1      | 1         |

To conclude, if we use an ordinary list, we run a risk of transmitting an incorrect output signal, because the actions are processed in the wrong order.
