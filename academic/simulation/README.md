## [Click here](https://christopherrutherford.shinyapps.io/simulation/) to access the shiny app on the web.

The primary purpose of this project is to demonstrate how various probability distributions (such as normal and binomial) and theorems (such as the central limit theorem) appear in everyday life through various simulations. Additionally, I wanted to teach myself how to make a Shiny app in R; this was the result.

The dice rolling simulation is primarily used to demonstrate the summation of random variables (in this instance, uniform RVs) and how, despite the underlying distribution not being uniform, more dice being rolled leads to a closer approximation of the normal distribution.

The coin flipping simulation is similar to the dice roll, as it also demonstrates random variable summation and a normal distribution approximation by summing the number of heads in each coin flip.

The dart simulation demonstrates how general randomness can occur. It also shows us how points near the center of the underlying distribution occur much more often compared to outliers that are far from the center.

The random walk demonstrates how certain real world stochastic objects behave. The first that comes to mind for most is the price of a stock, as it tends to fluctuates up and down for the most part. The 1D random walk only goes up or down, while the 2D random walk can go up, down, left, or right.


