#!/usr/local/bin/python
import matplotlib.pyplot as plt
import numpy as np
from numpy import genfromtxt
import random
import sys
def bagging(dataset):
    N = len(dataset[:,0])
    tmp_list = list()
    for i in range(N):
        sample = random.randint(0,N-1)
        tmp_list.append(dataset[sample,:])
    return np.array(tmp_list)
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

    def predict_labels(self,dataset):
        tmp_list = list()
        if(self.split ==False):
            for i in range(len((dataset[:,0]))):
                tmp_list.append([ dataset[i,3],self.constant])
        else:
            D1,D2 = self.split_data(dataset)
            if(self.lchild is not None):
                tmp_list+=(self.lchild.predict_labels(D1))
            if(self.rchild is not None):
                tmp_list+=(self.rchild.predict_labels(D2))
        return tmp_list

    def split_data(self,dataset):
        sorted_data = dataset[dataset[:,self.dim].argsort()]
        N = len(sorted_data[:,0])
        break_point = N
        for i in range(N):
            if(sorted_data[i,self.dim] >= self.theta_value):
                break_point = i
                break
        return sorted_data[0:break_point,:], sorted_data[break_point:N,:]


    def print_struct(self,depth):
        if(not (self.lchild is None)):
            self.lchild.print_struct(depth+1)
        if(not (self.rchild is None)):
            self.rchild.print_struct(depth+1)
        for i in range(10*depth):
            sys.stdout.write(' ')
        print self.dim, self.best_theta , self.N , self.impurity , self.theta_value , self.constant

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

        return min_inpurity

def count_error(truelabels,predict_labels):
    N = len(truelabels)
    #sorted_labels = predict_labels[predict_labels[:,0].argsort()]
    error  = 0.0
    for i in range(N):
        if(np.sign(truelabels[i])!=np.sign(predict_labels[i])):
            error += 1
    return error / N

def predict_labels(tree,arg_dataset):
    ret= np.array(tree.predict_labels(arg_dataset))
    sorted_ret = ret[ret[:,0].argsort()]
    return sorted_ret[:,1]

def argument_dataset(dataset):
    N = len(dataset[:,0])
    return np.c_[dataset , np.array(range(N))[np.newaxis].T ]

Train = genfromtxt('hw7_train.dat.txt', delimiter=' ')
Test = genfromtxt('hw7_test.dat.txt', delimiter=' ')
Ytrain = Train[:,2]
Ytest = Test[:,2]
Arg_Train = argument_dataset(Train)
Arg_Test = argument_dataset(Test)

#Arg_Train = np.c_[Train , np.array(range(len(Train[:,0])))[np.newaxis].T ]
#Arg_Test = np.c_[Train , np.array(range(len(Test[:,0])))[np.newaxis].T ]

#c = Cart(Train)
#print count_error(Ytrain,predict_labels(c,Arg_Train))
#print count_error(Ytest,predict_labels(c,Arg_Test))
#print c.predict_labels(Arg_Train)

#print count_error(Train[:,2],np.array(c.predict_labels(Arg_Train)))
Eins = list()
Eouts = list()
TreeList = list()
T = 30000
Ein_label_buffer = np.zeros(len(Train[:,0]))[np.newaxis].T
Eout_label_buffer = np.zeros(len(Test[:,0]))[np.newaxis].T
for i in range(T):
    print "iteration = %s "%i
    TrainBag = bagging(Train)
    N = len(Train[:,0])
    c = Cart(TrainBag)
    #print np.c_[Ein_label_buffer, predict_labels(c,Arg_Train)]
    Ein_label_buffer = np.sum(np.c_[Ein_label_buffer, predict_labels(c,Arg_Train)],axis=1).T
    Eout_label_buffer = np.sum(np.c_[Eout_label_buffer, predict_labels(c,Arg_Test)],axis=1).T
    #print Ein_label_buffer
    #print Eout_label_buffer
    #Ein_label_buffer = np.sum(predict_labels(c,Arg_Train).T,Ein_label_buffer.T)
    #Eout_label_buffer= np.sum(predict_labels(c,Arg_Test).T,Eout_label_buffer.T)
    Ein = count_error(Ytrain,Ein_label_buffer)
    Eout = count_error(Ytest,Eout_label_buffer)
    #Ein = c.predict(Train) * 1.0 / N
    Eins.append(Ein)
    Eouts.append(Eout)

plt.plot(range(1,T+1),Eins)
#x1,x2,y1,y2 = plt.axis()

#plt.axis((x1,x2,0,0.02))
plt.title("Ein through Iterations")
plt.xlabel("Iteration")
plt.ylabel("Ein")
plt.savefig('Ein.png')
plt.clf()
plt.plot(range(1,T+1),Eouts)

plt.title("Eout through Iterations")
plt.xlabel("Iteration")
plt.ylabel("Eout")
plt.savefig('Eout.png')
print Eins
