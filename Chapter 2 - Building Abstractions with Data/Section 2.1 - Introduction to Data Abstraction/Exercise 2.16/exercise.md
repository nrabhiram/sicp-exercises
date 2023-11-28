# Exercise 2.16

Explain, in general, why equivalent algebraic expressions may lead to different answers. Can you devise an interval-arithmetic package that does not have this shortcoming, or is this task impossible? (Warning: This problem is very difficult.)

# Solution

It isn't possible to create an interval-arithmetic package that doesn't have the dependency problem because [not every function can be reduced to a form in which every variable appears only once](https://stackoverflow.com/a/67394859). But, there exists an alternative numerical method called the *Monte Carlo Simulation* for which the dependency problem doesn't exist. 

## Monte Carlo Simulation

This is a mathematical technique that allows you to estimate possible outcomes of an uncertain event by modeling the probability of different outcomes in a system that can't be easily predicted due to factors we don't have control over. We use a method called *random sampling* to generate multiple possible outcomes and then calculate the average result.

To perform the Monte Carlo Simulation,

1. We set up the predictive model. This identifies the dependent variable to be predicted and the independent variables that will drive the predictions.
2. Next, we specify the probability distribution of the independent variables. You can use historical data or an analyst's subjective judgement to define a range of likely values and assign probability weights for each.
3. Finally, we run simulations by repeatedly generating random values for the independent variables until we have a representative sample of the infinite number of possible combinations.

So, for example, when you calculate `A/A` with the Monte Carlo method, you submit random values inside the interval to represent every occurrence of `A` in the formula. In this case, the value of the function will be `1`, no matter how many random values you generate. Finally, when you take the min/max of all function values, we realize that final result is 1, with **zero tolerance**.