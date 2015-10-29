#!/usr/bin/python
class vector:
	def __init__(self,n):
		self.value = [0]*n

	def set_value_by_vector(self,v):
		if(v.length() != self.length() ):
			print "Error"
			return -1;
		for i in range(v.length()):
			self.value[i]=v.value[i]
		#print (self.value,self.length);

	def set_value_by_list(self,v):
		if(len(v)!=self.length()):
			return -1
		for i in range(len(v)):
			self.value[i] = v[i]
		#print (self.value,self.length);
	def output(self):
		print (self.value)

	def add(self,v):
		if(v.length()!= self.length()):
			return -1;
		ret = vector(v.length())
		for i in range(v.length()):
			ret.value[i]= v.value[i] + self.value[i]
		return ret

	def inner_product(self,v):
		if(self.length() != v.length()):
			return -1;
		ret =0 ;
		for i in range(v.length()):
			ret = ret + v.value[i]*self.value[i]
		return ret

	def length(self):
		return len(self.value)

	def extend_vector_by_constant(self,constant):
		ret = vector(self.length()+1)
		value_list = list()
		value_list.append(constant)
		ret.set_value_by_list(value_list+self.value)
		return ret

	def scale(self,scalar):
		ret = vector(self.length())
		for t in range(self.length()):
			ret.value[t] = self.value[t]*scalar
		return ret

def test():
	v = vector(3)
	v.set_value_by_list([1,2,3])
	v2 = vector(3)
	v2.set_value_by_vector(v)
	v.output()
	v2.output()
	v3 = v.add(v2)
	v3.output()
	inp = v3.inner_product(v2)
	print inp
#test()