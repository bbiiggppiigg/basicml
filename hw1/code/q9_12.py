#!/usr/bin/python
import math
import numpy
def nCr(n,r):
    f = math.factorial
    return f(n) / f(r) / f(n-r)
def expo(x,n):
	ret = 1
	for i in range(n):
		ret = ret * x
	return ret

print nCr(10,5)* expo(0.5,10)
print nCr(10,9) * expo(0.9,9) * 0.1
print nCr(10,0)*expo(0.1,10) + nCr(10,1) * (0.9)*expo(0.1,9)
print 2 * numpy.exp(-12.8)
