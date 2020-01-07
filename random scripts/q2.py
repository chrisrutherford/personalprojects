A=[1,7,8,16,22,29]
B=[50,40,30,20,10,1]
n=len(A)
def MergeArrays(A,B,n):
    C=[]
    for i in range(2*n):
        C.append(None)

    i,k=0,0
    j=n-1
    while i<n and j>=0:
        if A[i]==B[j]:
            C[k],C[k+1]=A[i],A[i]
            i+=1
            j-=1
            k+=2
        elif A[i]<B[j] or i==n-1:
            C[k]=A[i]
            k+=1
            i+=1
        elif A[i]>B[j] or j==1:
            C[k]=B[j]
            k+=1
            j-=1
    return C
