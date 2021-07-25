# some stuff with hurricane data

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score
#import seaborn; seaborn.set()

hurricanes=pd.read_csv("https://raw.githubusercontent.com/chrisrutherford/sta4032/master/hurricanes.csv")
year=hurricanes["Year"].to_frame()
hurrCount=hurricanes["Hurricanes"].to_frame()
majorCount=hurricanes["Major hurricanes"].to_frame()

linReg=LinearRegression(n_jobs=-1)
hurrModel=linReg.fit(year,hurrCount)

fig,(ax1,ax2)=plt.subplots(nrows=2,sharex=True)

ax1.set(title="Hurricanes and major hurricanes, 1851-2017")
ax1.plot(year, hurrCount, color='blue', linewidth=0.6)
ax1.plot(year, linReg.predict(year), color='blue', linewidth=0.6)
ax1.set_ylabel("Hurricanes")

#print("y="+str(hurrModel.coef_)+"*year + "+str(hurrModel.intercept_))
hurrR2=r2_score(hurrCount,linReg.predict(year))

majorModel=linReg.fit(year,majorCount)
ax2.plot(year, majorCount, color='red', linewidth=0.6)
ax2.plot(year, linReg.predict(year), color='red', linewidth=0.6)
ax2.set_ylabel("Major Hurricanes")
plt.show()

# equation y=majorModel.coef_*year + majorModel.intercept_
print("Hurricane R^2:", hurrR2)
print("Major Hurricane R^2:",r2_score(majorCount,linReg.predict(year)))