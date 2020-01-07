from time import time
def insertionSort(A):
    '''sorts numbered or alphabetical (all lowercase or all uppercase) list'''
    n=len(A)
    t1=time()
    for j in range(1,n):
        currentVal=A[j]
        pos=j
        while pos>0 and A[pos-j]>currentVal:
            A[pos]=A[pos-1]
            pos-=1
        A[pos]=currentVal
    t2=time()
    return (t2-t1)*1000
