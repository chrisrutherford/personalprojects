def walk(n,d):
    '''walks a random distance between 0 and d, n times'''
    import turtle
    import random
    turtle.speed("fastest")


    for i in range(n):
        turtle.forward(random.randint(0,d))
        turtle.right(random.randint(0,360))
