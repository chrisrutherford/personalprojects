def basePowerList(b,p):
    '''calculates b to the pth, p-1, p-2,... power'''
    try:
        b,p=int(b),int(p)
    except:
        raise ValueError("Arguments must be intergers")
    else:
        pows=[]
        while p>0:
            result=b**p
            pows.append(result)
            p-=1
        return pows
