#!/usr/bin/env python3
# -*- coding: utf-8 -*-


from math import sqrt
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns; sns.set()

number_to_estimate = float(input("Which number would you like to estimate the square root of? "))
iterations = int(input("How many times should it iterate? "))
initial_estimate = float(input("What is your estimate of the square root of {}? ".format(number_to_estimate)))
x = [initial_estimate]
error = [np.nan]

print("Estimating square root of", number_to_estimate)
print("Running through method", iterations, "times")
print("Initial estimate:", initial_estimate)


for i in range(iterations):
    initial_estimate = ((number_to_estimate / initial_estimate) + initial_estimate) / 2
    x.append(initial_estimate)
    error.append(sqrt(number_to_estimate) - initial_estimate)

print("Actual square root: {}".format(sqrt(number_to_estimate)))
print("Approximate error (to about 15 decimal places):", str(abs(sqrt(number_to_estimate) - initial_estimate)))

fig, (ax1, ax2) = plt.subplots(nrows=1, ncols=2)
ax1.plot(x)
ax1.legend(['Estimate'],loc='upper right')
ax2.plot(error)
ax2.legend(['Error'],loc='upper right')
plt.suptitle("Estimation of square root of "+str(number_to_estimate))
plt.show()