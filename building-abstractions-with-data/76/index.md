---
slug: exercise-2-76
name: Exercise 2.76
date: 27-05-26 23:41
---

As a large system with generic operations evolves, new types of data objects or new operations may be needed. For each of the three strategies — generic operations with explicit dispatch, data-directed style, and message-passing-style — describe the changes that must be made to a system in order to add new types or new operations. Which organization would be most appropriate for a system in which new types must often be added? Which would be most appropriate for a system in which new operations must often be added?

## Solution

Before examining the three strategies, keep in mind the table we use for the data-directed style, which is indexed by operations and types for the vertical and horizontal axes.

### Explicit Dispatch

In the *explicit dispatch* technique, we decompose the table into rows. The generic interface procedures we create for each operation is responsible for dispatching an action based on the type of the argument.

When a new type is added to the system, we add a clause for how it needs to be handled in each of the generic interface procedures.

When a new operation is added to the system, we create a new generic procedure for it. It will define clauses for how the operation handles each one of the various representations.

This technique has a couple of disadvantages.

- **name collision:** Every time we create a new type, we have to ensure that its selectors and constructors don't collide with the other types in the system. The changes themselves are straightforward, but they can be cumbersome and a source of errors.
- **The generic interface procedures must keep track of all possible representations.** Every time we create a new type, we need to add clauses for this type in each of these procedures.

### Data Directed Style

*Data-directed style* is the most versatile amongst the 3 organizational techniques. It manipulates the table explicitly, thus lifting the burden of remembering the various representations off from the maintainers of the system. It also allows for combinations of multiple types for each operation.

We create packages for each representation, define procedures corresponding to each operation, and insert them in the table at the position indexed by the operation name and list of types of the arguments. Note how we need not concern ourselves with the structural details of another type because we can operate on them by indicing the table and accessing the corresponding procedure.

When a new type is added to the system, we create a package as mentioned above.

When a new operation is added to the system, we define corresponding internal procedures in each of the packages, and add it to the table when the package is installed. Then, we create a generic interface procedure for the operation, that calls `apply-generic`, which itself invokes `get` to find the procedure, and applies it to the arguments.

```racket
(define (apply-generic op . args) 
  (let ((type-tags (map type-tag args))) 
    (let ((proc (get op type-tags))) 
      (if proc 
          (apply proc (map contents args)) 
          (error "No method for these types: APPLY-GENERIC" (list op type-tags))))))
```

I think that this approach is the most general-purpose one of the three.

### Message Passing Style

In the *message-passing style*, we decompose the table into columns. Each type is represented as a higher order procedure that returns a `dispatch` procedure. It has clauses for each operation and the corresponding calculations it needs to perform.

When we need to perform an operation on a data object, we use the following helper procedure.

```racket
(define (apply-generic op arg) (arg op))
```

When a new type is added to the system, we create a new constructor procedure for data objects of this type, with a `dispatch` procedure containing clauses for each of the possible operations.

When a new operation is added to the system, we need to add a clause in the constructors for data objects of every type.

The disadvantage with this technique is that it can only accept a single argument for the operation. It can't accept data objects of other types as arguments, because that would mean that it needs to understand the structure of other representations. This isn't feasible.

### Comparison

|                       | New type                            | New operation                          |
|-----------------------|-------------------------------------|----------------------------------------|
| **Explicit**          | Add clauses in each operation proc  | Create proc with clauses for all types |
| **Data-directed**     | Create and install a new package    | Generic interface proc + update pkgs   |
| **Message-passing**   | Create new constructor for the type | Add clause in every constructor        |

### Conclusion

For a system in which new types must often be added, the **message-passing** strategy is most appropriate. It's more straightforward to set up than the data-directed approach, and requires less drudgery than the explicit dispatch approach whenever a new type has to be added to the system.

For a system in which new operations must often be added, the **data-directed** strategy is most appropriate. Its versatility is unmatched. Unlike the message-passing approach, we can have multiple arguments without needing to know how a data object is structured, and we don't have to remember all of the various representations and explicitly create clauses for each type every time we create a generic interface procedure for a new operation. Instead, the work is localized, i.e. the corresponding procedure for the operation must be defined in the package and added to the table on installation.
