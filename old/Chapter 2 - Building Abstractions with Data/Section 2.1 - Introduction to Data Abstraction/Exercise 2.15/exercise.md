# Exercise 2.15

Eva Lu Ator, another user, has also noticed the different intervals computed by different but algebraically equivalent expressions. She says that a formula to compute with intervals using Alyssa’s system will produce tighter error bounds if it can be written in such a form that no variable that represents an uncertain number is repeated. Thus, she says, `par2` is a “better” program for parallel resistances than `par1`. Is she right? Why?

# Solution

Eva is right in saying that `par2` is a better program for parallel resistances than `par1`. In the application of interval arithmetic for complex functions, i.e. functions that consist of variables (or intervals) that repeat multiple times, we come across the *dependency problem*.

*If an interval occurs several times in a calculation using parameters, and each occurrence is taken independently, then this can lead to an unwanted expansion of the resulting intervals.*