import time
def runTime(n):
    '''runtime for nested loop where inner loop depends on outer loop'''
    count=0
    compi=0
    compj=0
    start=time.time()
    for i in range(1,n+1):
        compi+=1
        for j in range(1,i+1):
            calc=i*j
            count+=1
            compj+=1
    end=time.time()
    total=(end-start)
    if total>1:
        print(total,'seconds')
    else:
        print(total*1000,'milliseconds')
    print(count,'products calculated')
    print(compi,'comparisons for outer loop')
    print(compj,'comparisons for inner loop')
    print(count+compi+compj,'total operations')
