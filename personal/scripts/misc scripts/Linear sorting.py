A=[5,1,0,5,0,3,0,1]
B=[2,5,3,0,2,3,0,3]

def countSort(A):
    n=len(A)
    k=max(A)
    B=[0 for i in range(n)] #output array

    #2-3
    C=[0 for i in range(k+1)] #counter/auxiliary array

    #4-5
    for j in range(n): #0 to n-1
        C[A[j]]+=1
    
    #7-8
    for i in range(1,k+1): #cumulative sum of numbers <=k
        C[i]+=C[i-1]

    #10-12
    for j in range(n-1,-1,-1): #n-1 down to 0
        B[C[A[j]]-1]=A[j]
        C[A[j]]-=1
    return B
