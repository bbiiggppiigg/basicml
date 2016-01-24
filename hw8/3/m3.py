#!/usr/local/bin/python
import copy
max_list = list();
def count_weights(hidden_list):
	#print "list = ",hidden_list
	sum_weights = 11 * (hidden_list[0]-1);

	for i in range(1,len(hidden_list)):
		sum_weights+= (hidden_list[i-1]*(hidden_list[i]-1))
	sum_weights += hidden_list[len(hidden_list)-1];
	#print sum_weights
	return sum_weights

def search_max(hidden_list, spare , depth):
	init_weights = count_weights(hidden_list)

	if(depth == len(hidden_list)-1):
		tmp = hidden_list;
		tmp[depth]+= spare;
		return count_weights(tmp);

	for i in range(spare+1):
		tmp = hidden_list;
		tmp[depth]+=i;
		tmp_weights = search_max(tmp,spare-i,depth+1)
		if(init_weights < tmp_weights):
			init_weights = tmp_weights
	return init_weights

def search_max_list(hidden_list, spare , depth):

	ret_weights = count_weights(hidden_list)

	ret_list = copy.deepcopy(hidden_list)

	if(depth == len(hidden_list)-1):
		tmp = copy.deepcopy(hidden_list);
		tmp[depth]+= spare;
		return tmp;

	for i in range(spare+1):
		tmp = copy.deepcopy(hidden_list);
		tmp[depth]+=i;

		tmp_list = search_max_list(tmp,spare-i,depth+1)
		#print tmp_list
		tmp_weights = count_weights(tmp_list)
		if(ret_weights < tmp_weights):
			ret_weights = tmp_weights
			ret_list = copy.deepcopy(tmp_list)

	return ret_list



for num_hidden_layer in range(1,19):
	num_hidden = list();
	total = 36;
	for i in range(num_hidden_layer):
		num_hidden.append(2);
		total -= 2;

	max_list = search_max_list(num_hidden,total,0)
	print num_hidden_layer,max_list , count_weights(max_list)
	#print num_hidden_layer , total , return_weights(num_hidden)
