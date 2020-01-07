A=[1,6,9,2,27,7,35,18]
p=0
r=len(A)-1
def randomizedSelect(A,p,r,i):
    if p==r:
        return A[p]
    q=randomizedPartition(A,p,r)
    print(A)
    k=q-p+1
    if i==k:
        print(A,q)
        return A[q]
    elif i<k:
        print(A,i)
        return randomizedSelect(A,p,q-1,i)
    else:
        print(A,i-k)
        return randomizedSelect(A,q+1,r,i-k)

def randomizedPartition(A,p,r):
    from random import randint
    i=randint(p,r)
    A[i],A[r]=A[r],A[i]
    return partition(A,p,r)

def partition(A,p,r):
    x=A[r]
    i=p-1
    for j in range(p,r):
        if A[j]<=x:
            i+=1
            A[i],A[j]=A[j],A[i] 
    A[i+1],A[r] = A[r],A[i+1]
    return i+1
