#!/usr/local/bin/python

import numpy as np
from numpy import genfromtxt
import sys
class Cart:
    best_theta = 0
    dim = 0
    lchild = None
    rchild = None
    N  = 0
    impurity = 0
    theta_value = 0;
    constant =0
    split = False
    def __init__(self,dataset):
        self.impurity = self.d_stump(dataset)
        if(self.split==True):
            self.lchild = Cart(self.D1)
            self.rchild = Cart(self.D2)
        else:
            self.constant = dataset[0,2]

        #print self.best_theta,self.direct,self.dim
    def predict(self,dataset):
        error = 0
        if(self.split ==False):
            for i in range(len((dataset[:,0]))):
                if(self.constant!= np.sign(dataset[i,2])):
                    error += 1
        else:
            D1,D2 = self.split_data(dataset)
            #print "data split to len "+ str(len(D1[:,0]))+" "+str(len(D2[:,0]))
            if(self.lchild is not None):
                error += self.lchild.predict(D1)
            if(self.rchild is not None):
                error += self.rchild.predict(D2)

        return error

    def split_data(self,dataset):
        sorted_data = dataset[dataset[:,self.dim].argsort()]
        N = len(sorted_data[:,0])
        break_point = N
        for i in range(N):
            if(sorted_data[i,self.dim] >= self.theta_value):
                break_point = i
                break
        #print "break point = %s , break_point_value = %s" % (break_point,sorted_data[break_point-1,self.dim])
        return sorted_data[0:break_point,:], sorted_data[break_point:N,:]


    def print_struct(self,depth):
        if(not (self.lchild is None)):
            self.lchild.print_struct(depth+1)
        if(not (self.rchild is None)):
            self.rchild.print_struct(depth+1)
        for i in range(10*depth):
            sys.stdout.write(' ')
        print self.N ,self.dim, self.theta_value , self.constant

    def count_impurity(self,D):
        N = len(D[:,0])
        if(N==0):
            return 0
        neg_count = 0.0
        pos_count = 0.0
        for i in range(N):
            if(D[i,2]==1):
                pos_count = pos_count+1;
            else:
                neg_count = neg_count+1;
        return N*(1- pow((pos_count/N),2) - pow((neg_count/N),2))

    def d_stump(self,dataset):
        N = len(dataset[:,0]);
        self.N= N
        min_inpurity = 2*N
        for d in range(2):
            sorted_data = dataset[dataset[:,d].argsort()]
            for i in range(N+1):
                D1 = sorted_data[0:i,:]
                D2 = sorted_data[i:N,:]

                argmin = self.count_impurity(D1)+self.count_impurity(D2)
                if(argmin < min_inpurity ):
                    min_inpurity = argmin
                    self.best_theta = i
                    self.D1 = D1
                    self.D2 = D2
                    self.dim = d
                    if(self.best_theta==0):
                        self.theta_value = -np.inf
                    elif (self.best_theta ==N):
                        self.theta_value== np.inf
                    else:
                        self.split = True
                        self.theta_value = (sorted_data[self.best_theta,self.dim]+sorted_data[self.best_theta-1,self.dim])/2

        #print "data split to len "+ str(len(self.D1[:,0]))+" "+str(len(self.D2[:,0]))+" theta_value = "+str(self.theta_value)+" i = %s "%self.best_theta
        #print "data split to len : %s %s with theta_value %s i = %s" % (self.D1.shape[0] , self.D2.shape[0] ,  self.theta_value , self.best_theta)
        return min_inpurity


Train = genfromtxt('hw7_train.dat.txt', delimiter=' ')
Test = genfromtxt('hw7_test.dat.txt', delimiter=' ')

c = Cart(Train)
c.print_struct(0)
print ""
print c.predict(Train)*1.0 / len(Train[:,0])
print c.predict(Test)*1.0 / len(Test[:,0])
