#!/usr/local/bin/python
from vector import vector
import random
import matplotlib.pyplot as plt
import numpy as np

class dataset:
	def __init__(self):
		self.input_vectors = list()
		self.labels = list()		

def fetch_input(filename,x0):
	d = dataset()
	with open(filename) as f:
		for line in f:
			(x1,x2,x3,x4,y1) = line.split()
			#print (x1,x2,x3,x4,y1)
			v = vector(5)
			v.set_value_by_list([x0,float(x1),float(x2),float(x3),float(x4)])
			d.input_vectors.append(v)
			d.labels.append(float(y1))
	return d

def sign(value):
	if(value>0):
		return 1
	else:
		return -1;


def initialize_and_permute(permutation,n):
	for i in range(n): 
		j = random.randint(0,n-1)
		temp = permutation[i]
		permutation[i] = permutation[j];
		permutation[j] = temp;

def init_sequence(n):
	ret = list()
	for i in range(n):
		ret.append(i)
	return ret

def cyclic_pla():
	w = vector(5)
	x0 = 1
	d = fetch_input("hw1_15_train.dat",x0)
	updated = True
	counter = 0
	last_index =0 
	while updated:
		updated = False
		for t in range(len(d.input_vectors)):
			if(sign(d.input_vectors[t].inner_product(w))!= d.labels[t]):
				w = d.input_vectors[t].scale(d.labels[t]).add(w)
				updated = True
				counter = counter +1
				last_index = t
	print counter
	w.output()
	print last_index

def rand_start_pla(d):
	w = vector(5)
	updated = True
	counter = 0
	last_index =0 
	seq = init_sequence(len(d.input_vectors))
	initialize_and_permute(seq,len(d.input_vectors))
	while updated:
		updated = False
		for i in range(len(d.input_vectors)):
			t = seq[i]
			if(sign(d.input_vectors[t].inner_product(w))!= d.labels[t]):
				w = d.input_vectors[t].scale(d.labels[t]).add(w)
				updated = True
				counter = counter +1
				last_index = t
	return counter

def rand_start_pla_exp():
	x0 = 1
	d = fetch_input("hw1_15_train.dat",x0)
	result = list()
	for i in range(2000):
		result.append(rand_start_pla(d))
	plt.hist(result, 100, histtype='stepfilled')
	plt.title("Random Cycle PLA")
	plt.xlabel("Update Counts")
	plt.ylabel("Frequency")
	plt.savefig('q16.png')
	print "The Average number of update is %f " % np.average(result)

rand_start_pla_exp()