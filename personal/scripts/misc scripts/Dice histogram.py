import matplotlib.pyplot as plt
import numpy as np

x=np.random.randint(1,7,(100000,10))
y=np.sum(x,axis=1)
probs=np.array([0 for i in range(10,61)])

plt.hist(y,color='red')
plt.xlabel("Sum")
plt.ylabel("Probability")
plt.title("Dice Rolls")


for i in range(10,61):
    probs[i-10]=np.sum(y==i)
print(probs)