def fib(n):
    '''returns fibonacci numbers less than n'''
    try:
        n=int(n)
    except:
        return "input must be an integer"
    if n<1:
        return "input must be positive"
    f0,f1=0,1
    yield 0
    while n>f1:
        f0,f1=f1,f0+f1
        yield f0
    
def prime(n):
    '''returns first n primes'''
    try:
        n=int(n)
    except:
        return "input must be an integer"
    if n<1:
        return "input must be positive"
    count=2
    while count<n:
        if isPrime(count):
            yield count
        count+=1

def isPrime(n):
    '''tests if number is prime'''
    for i in range(2, int(n**0.5+1)):
        if n%i==0:
            return False
    return True

    
def pascal(n):
    '''return nth row of pascal's triangle'''
    from math import factorial as f
    for i in range(n+1):
        yield f(n)//(f(i)*f(n-i))
    






    
