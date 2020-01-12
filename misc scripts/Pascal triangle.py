from math import factorial as f

def ncr(n,r):
    return f(n)//(f(r)*f(n-r))

def pascal(k):
    triangle=[0] #dummy variable/integer for printing row 0
    indent='  '
    for i in range(0,k+2):
        if not (triangle==[0]):
            print (indent*(k-i+1),triangle)
        triangle=[]
        for j in range(0,i+1):
            triangle.append(ncr(i,j))
            
