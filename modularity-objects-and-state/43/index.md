---
slug: exercise-3-43
name: Exercise 3.43
date: 28-09-26 16:00
---

Suppose that the balances in three accounts start out as $10, $20, and $30, and that multiple processes run, exchanging the balances in the accounts. Argue that if the processes are run sequentially, after any number of concurrent exchanges, the account balances should be $10, $20, and $30 in some order. Draw a timing diagram like the one in Figure 3.29 to show how this condition can be violated if the exchanges are implemented using the first version of the account-exchange program in this section. On the other hand, argue that even with this `exchange` program, the sum of the balances in the accounts will be preserved. Draw a timing diagram to show how even this condition would be violated if we did not serialize the transactions on individual accounts.

## Solution

Let's say that: 

- Peter performs an exchange between *a1* and *a2*
- Paul performs an exchange between *a2* and *a3*

In this scenario, the exchange is an atomic operation, i.e. it can't be interrupted by another concurrent process. So, another exchange can only occur after the first exchange to be executed was completed.

Let's assume that Paul's exchange was the first one to be executed. This is the result of the exchange.

```
a1: $10, a2: $30, a3: $20
```

Note that the account balances are preserved in some order.

Now, Peter's exchange is executed. The following is the state of the system after this.

```
a1: $30, a2: $10, a3: $20
```

The account balances are again preserved, just in a different order.

Now, if we use the first account-exchange program in this section, the events in each exchange operation can be interleaved, i.e. computing the difference, and performing the withdrawal and deposit. Note that in this scenario, although the exchange isn't atomic, the withdrawals and deposits still are. This is the reason why although the account balances aren't preserved, the sum of balances is still preserved.

If even the transactions on individual accounts are no longer serialized, the events during a withdrawal or deposit can be interleaved. Let's consider the above scenario where Peter and Paul perform exchanges. But, the withdrawal and deposit to *a2* are interleaved in such a way that the reads of the balance happen successively, the withdrawal in Paul's exchange happens, and then finally, the deposit in Peter's exchange happens. *a2* gets set to $30 initially, but its final value will be $10. Whereas *a1* and *a3* will be $20 each. As you can see, the final sum of balances doesn't add up to $60.
