def collatz(n):
    try:
        n=int(n)
    except:
        raise TypeError("Input must be a positive integer")
    if n<1:
        return "Input must be a positive integer"
    else:
        col=[]
        while n>1:
            if n%2==0:
                n=n//2
            else:
                n=n*3+1
            col.append(n)
        return col
