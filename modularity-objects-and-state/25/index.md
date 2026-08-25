---
slug: exercise-3-25
name: Exercise 3.25
date: 26-08-26 00:56
---

Generalizing one- and two-dimensional tables, show how to implement a table in which values are stored under an arbitrary number of keys and different values may be stored under different numbers of keys. The `lookup` and `insert!` procedures should take as input a list of keys used to access the table.

## Solution

In my first attempt at writing a general solution for an *n*-dimension table (which you can check [here](./solution_old.rkt)), a major flaw of this implementation is that **it can't support values of records that are lists**. 

As we traverse through the nested subtables to insert values, we need a way to distinguish between records and tables – sometimes, we have to convert an existing record, that lacks the ability to hold a list of records, into a table so that it can. This was implemented haphazardously, leading to convolution and intermixing of the operations that can be performed on tables, and the internal representation of tables themselves. To check whether a subtable is actually a record, we check if its `cdr` is not a pair.

> Implement a table in which values are stored under an arbitrary number of keys and different values may be stored under different numbers of keys

A robust and generalized solution should also be able to separately hold a value for a key and a list of records that can further be keyed into. In this implementation, along with the heading dummy record that indicates that a structure is a table, we maintain another record at the head for the value.

The above mentioned flaw and the muddling of abstractions led me to rewriting the solution. Maintaining abstraction barriers for our representation of the table structure and the operations we can perform on them helped me gain immense clarity. Otherwise, operations on pairs are sprinkled across in the logic for insertions and lookups.

In this generalization, what is a table, and what is a record? They're the same thing. A table can hold a value, and also contain records. A record is just a specific version of a table that has an empty list of records. To not further complicate the solution, I labeled this shared type as a node, and created a constructor, selectors, and mutators for it, which `insert!` and `lookup` use.

`lookup` generates an iterative process. So, it has an order of growth of space of *Θ(1)*. As for the number of steps, each time we locate the corresponding subtable for a key, we scan the list of records for the table. So, if we have *k* keys and each table we key into has *n* records, the order of growth of steps would be *Θ(k×n)*.

Depending on circumstances, `insert!` could generate either an iterative or recursive process. If the subtables exist for the full path of keys, at each stage, we just mutate the list of records – the resultant values aren't required for deferred operations. However, if subtables don't exist for the path of keys, we have to initialize a node for the key, mutate it by calling `insert!`, and finally `cons`ing the record onto the list of existing records for the table. This leads to a chain of deferred `cons` operations. So, the order of growth of space in this case would be *Θ(k)*. Otherwise, it'd be *Θ(1)*. At each level, we might need to scan the entire list of records. So, the order of growth of steps is *Θ(k×n)*.

| Procedure | Situation                              | Steps    | Space  |
| --------- | -------------------------------------- | -------- | ------ |
| `lookup`  | general case | *Θ(k×n)*                | *Θ(1)*   |        |
| `insert!` | full key path already exists           | *Θ(k×n)* | *Θ(1)* |
| `insert!` | new chain of subtables must be created | *Θ(k×n)* | *Θ(k)* |

Here, *k* is the number of keys and *n* is the maximum number of records scanned at each level.
