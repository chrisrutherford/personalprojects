#!/usr/bin/env python3
# -*- coding: utf-8 -*-

x,y,a=300,10,6

from math import sqrt
def bab(x,y,a):
    '''estimates sqrt(x) with y iterations of babylonian method
    with a as initial estimate of sqrt(x)'''
    
    print("estimating square root of",x)
    print("running through method",y,"times")
    print("initial estimate:",a)
    
    for i in range(y):
        a=(x/a+a)/2
    print("approximate error:",str(sqrt(x)-a))
    return a