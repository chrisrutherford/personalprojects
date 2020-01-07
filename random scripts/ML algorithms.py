import pandas
from pandas.plotting import scatter_matrix
import matplotlib.pyplot as plt

from sklearn import model_selection
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score

from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC

url="https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
names=['sepal-length', 'sepal-width',
        'petal-length', 'petal-width', 'class']
dataset=pandas.read_csv(url, names=names)

#print(dataset.shape)   #dimensions of data
#print(dataset.head(10)) #first 10 data points of dataset

#print(dataset.groupby('class').size()) #number of rows belonging to each class


####Visualising Data

###univariate plots
##box plot - figure 1
dataset.plot(kind='box',subplots=True,layout=(2,2),sharex=False,sharey=False)


##histogram
dataset.hist()

##multivariate scatter matrix
scatter_matrix(dataset)

##Implementing ML algorithms
array=dataset.values
x=array[:,0:4]
y=array[:,4]
valid_size=.2
seed=7
xtrain,xvalid,ytrain,yvalid=model_selection.train_test_split(x,y,
    test_size=valid_size,random_state=seed)

#test new data
scoring='accuracy'

#testing various algorithms
models=[]
models.append(('Logistic', LogisticRegression()))
models.append(('LDA', LinearDiscriminantAnalysis()))
models.append(('k-NN', KNeighborsClassifier()))
models.append(('Decision Tree', DecisionTreeClassifier()))
models.append(('Normal',GaussianNB()))
models.append(('SVM',SVC()))

results,names=[],[]
for name, model in models:
    kfold=model_selection.KFold(n_splits=10,random_state=seed)
    cv_results=model_selection.cross_val_score(model,
        xtrain,ytrain,cv=kfold,scoring=scoring)
    results.append(cv_results)
    names.append(name)
    msg=name+": "+str(cv_results.mean())+" ("+str(cv_results.std())+")"
    print(msg)

#plot comparison of algorithms
fig=plt.figure()
fig.suptitle('Algorithm comparison')
ax=fig.add_subplot(111)
plt.boxplot(results)
ax.set_xticklabels(names)

#make predictions on validation dataset - most accurate is SVM for seed 7
svc=SVC()
svc.fit(xtrain,ytrain)
predictions=svc.predict(xvalid)
print('\n','Accuracy: ',accuracy_score(yvalid,predictions))
print(confusion_matrix(yvalid,predictions))
print(classification_report(yvalid,predictions))

#validation of k-NN
knn=KNeighborsClassifier()
knn.fit(xtrain,ytrain)
predictions=knn.predict(xvalid)
print('\n','Accuracy: ',accuracy_score(yvalid,predictions))
print(confusion_matrix(yvalid,predictions))
print(classification_report(yvalid,predictions))


plt.show()
