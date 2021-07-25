##Law of Large Numbers

from numpy.random import randn  # normal distribution random sampler
from scipy.stats import norm  # calculate area under normal pdf
import matplotlib.pyplot as plt
import numpy as np

n = int(input("Enter the desired sample size: "))
mu = int(input("Enter the desired mean: "))
sigma = int(input("Enter the desired standard deviation: "))
sd_range = int(input("Enter the desired number of standard deviations away from the mean: "))

'''law of large numbers with normal distribution'''
sample = mu + sigma * randn(n)  # creates the desired sample
count = 0  # counts values within desired range
largest = max(sample)
smallest = min(sample)

for i in sample:
    if not (i - sd_range * sigma > mu or i + sd_range * sigma < mu):
        count += 1
    if i > largest:
        largest = i
    if i < smallest:
        smallest = i

cdf_range = sigma * sd_range  ##used to calculate desired area
# under normal curve

act_percent = str((count / n) * 100) + "%"  ##actual percent of desired
# samples within specified range

# theoretical percent of desired samples within specified range
expected_percent = str((norm(mu, sigma).cdf(mu + cdf_range) - norm(mu, sigma).cdf(mu - cdf_range)) * 100) + "%"

print("Total sample size:", n)
print("Total desired values:", count)
print("Largest value:", largest)
print("Smallest value:", smallest)
print("Expected percent of values within", str(sd_range), "standard devs of the mean:", expected_percent)
print("Actual percent of values within", str(sd_range), "standard devs of the mean:", act_percent)

n, bins, patches = plt.hist(sample, 100, density=1, facecolor='b', alpha=0.7)
(sample_mean, sample_var) = norm.fit(sample)
y = norm.pdf(bins, sample_mean, sample_var)
l = plt.plot(bins, y, linewidth=2, color='red')
plt.xlabel("Value")
plt.ylabel("Probability")
plt.title("Histogram of Sample: $\overline{x}=%.3f,\ s=%.3f$" % (sample_mean, sample_var))
plt.xlim([mu - 4 * sigma, mu + 4 * sigma])
plt.grid(True)

# lines for theoretical range for given sd range
plt.axvline(x=mu - cdf_range, c='black', linewidth=2, linestyle=':')
plt.axvline(x=mu + cdf_range, c='black', linewidth=2, linestyle=':')

# lines for actual values for given sd range
plt.axvline(x=sample_mean - sd_range * sample_var, c='g', linewidth=2)
plt.axvline(x=sample_mean + sd_range * sample_var, c='g', linewidth=2)
plt.show()
