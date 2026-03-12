---
slug: exercise-2-16
name: Exercise 2.16
date: 26-03-12 15:12
---

Explain, in general, why equivalent algebraic expressions may lead to different answers. Can you devise an interval-arithmetic package that does not have this shortcoming, or is this task impossible? (Warning: This problem is very difficult.)

## Solution

It isn't possible to create a general-purpose interval-arithmetic package that doesn't have the dependency problem because [not every function can be reduced to a form in which every variable appears only once](https://stackoverflow.com/a/67394859). Tightening the error bounds is a difficult problem to solve. Interval arithmetic plays it safe, but this leads to a wide range of results, which might not be helpful in more complex expressions where terms repeat.

There exists an alternative numerical method called the *Monte Carlo Simulation* that can find a statistical approximation for a solution, but loses the ability to provide guaranteed bounds that interval arithmetic offers.

### Monte Carlo Simulation

**Resource:** [https://www.ibm.com/think/topics/monte-carlo-simulation](https://www.ibm.com/think/topics/monte-carlo-simulation)

This is a mathematical technique that allows you to estimate possible outcomes of an uncertain event by modeling the probability of different outcomes in a system that can't be easily predicted due to factors we don't have control over. We use a method called *random sampling* to generate multiple possible outcomes and then calculate the average result.

To perform the Monte Carlo Simulation,

1. We set up the predictive model. This identifies the dependent variable to be predicted and the independent variables that will drive the predictions.
2. Next, we specify the probability distribution of the independent variables. You can use historical data or an analyst's subjective judgement to define a range of likely values and assign probability weights for each.
3. Finally, we run simulations by repeatedly generating random values for the independent variables until we have a representative sample of the infinite number of possible combinations.
