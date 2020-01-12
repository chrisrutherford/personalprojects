##Law of Large Numbers

from numpy.random import randn  ##RNG for normal distribution
from scipy.stats import norm    ##calculate area under normal pdf
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import numpy as np

def LLN(n,mu,sigma,sdRange):
    '''law of large numbers with normal distribution'''
    sample=mu+sigma*randn(n)    ##creates the desired sample
    count=0                     ##counts values within desired range
    largest=max(sample)
    smallest=min(sample)
    
    for i in sample:
        if not (i-sdRange*sigma>mu or i+sdRange*sigma<mu):
            count+=1
        if i>largest:
            largest=i
        if i<smallest:
            smallest=i
            
    cdfRange=sigma*sdRange              ##used to calculate desired area
                                        #under normal curve
    
    actPercent=str((count/n)*100)+"%"   ##actual percent of desired
                                        #samples within specified range
    

    #theoretical percent of desired samples within specified range
    expPercent=str((norm(mu, sigma).cdf(mu+cdfRange)-norm(mu, sigma).cdf(mu-cdfRange))*100)+"%"
    
    print("Total sample size:",n)
    print("Total desired values:",count)
    print("Largest value:",largest)
    print("Smallest value:",smallest)
    print("Expected percent of values within",str(sdRange),"sd of the mean:",expPercent)
    print("Actual percent of values within",str(sdRange),"sd of the mean:",actPercent)

    n, bins, patches=plt.hist(sample, 100, normed=1, facecolor='b',alpha=0.7)
    (sampleMean,sampleVar)=norm.fit(sample)
    y=mlab.normpdf(bins, sampleMean, sampleVar)
    l=plt.plot(bins, y, linewidth=2, color='red')
    plt.xlabel("Value")
    plt.ylabel("Probability")
    plt.title("Histogram of Sample: $\overline{x}=%.3f,\ s=%.3f$"%(sampleMean,sampleVar))
    plt.xlim([mu-4*sigma, mu+4*sigma])
    plt.grid(True)
    
    ##lines for theoretical range for given sd range
    plt.axvline(x=mu-cdfRange,c='black',linewidth=2,linestyle=':')
    plt.axvline(x=mu+cdfRange,c='black',linewidth=2,linestyle=':')
    
    ##lines for actual values for given sd range
    plt.axvline(x=sampleMean-sdRange*sampleVar,c='g',linewidth=2)
    plt.axvline(x=sampleMean+sdRange*sampleVar,c='g',linewidth=2)
    plt.show()
    


