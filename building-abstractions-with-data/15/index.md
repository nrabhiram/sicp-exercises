---
slug: exercise-2-15
name: Exercise 2.15
date: 26-03-12 12:02
---

Eva Lu Ator, another user, has also noticed the different intervals computed by different but algebraically equivalent expressions. She says that a formula to compute with intervals using Alyssa’s system will produce tighter error bounds if it can be written in such a form that no variable that represents an uncertain number is repeated. Thus, she says, `par2` is a “better” program for parallel resistances than `par1`. Is she right? Why?

## Solution

Yes, she is right. As explained in [Exercise 2.14](/exercise-2-14), the reason for this is the **dependency problem**. The system can't discern b/w 2 intervals used in an expression, although they're representing the same value. This inflates the tolerance, i.e. the error bounds will not be as tight as when we use the second formula, because the values for each resistor are used only once in that case.
