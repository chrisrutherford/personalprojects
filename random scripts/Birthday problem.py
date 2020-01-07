from random import randint

def birthday():
    values=[1,2,3,4,5,10,25,50,100,1000,10000,10000]
    m=0                         #counter of total people in all experiments
    
    for j in range(1,10001):    #experiment number
        bdayList=[]
        n=0
        bday=randint(1,365)
        while bday not in bdayList:
            bdayList.append(bday)
            bday=randint(1,365)
            n+=1
        m=m+n+1
        output=str(j)+" "+str(n+1)+" "+str(m/j)
        if j in values:
            print(output)
