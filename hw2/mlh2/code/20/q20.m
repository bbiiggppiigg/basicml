load hw2_train.dat
A = hw2_train;

best_error = 1000;
best_dim  = -1;
best_index = -1;

for dim = 1:9
	Test = [A(:,dim),A(:,10)];
	Test = sortrows(Test);
	for t = 1:size(Test,1)
		error_sum1 =0;
		error_sum2 =0;
		
		index = Test(t,1)-0.00001;
		
		for j = 1:size(Test,1)
			if(Test(j,1)>index)
				if(Test(j,2)>0)
					error_sum2 = error_sum2+1;
				else
					error_sum1 = error_sum1+1;
				end
			else
				if(Test(j,2)<0)
					error_sum2 = error_sum2+1;
				else
					error_sum1 = error_sum1+1;
				end
			end
		end

		if(best_error > error_sum1)
			best_error = error_sum1;
			direct = 1;
			best_dim = dim;
			best_index = index;
			fprintf('direct = %d best_index =%d error_sum1 = %d error_sum2 =%d\n',direct,best_index,error_sum1,error_sum2);
		end
		
		if(best_error > error_sum2)
			best_error = error_sum2;
			direct = -1;
			best_dim = dim;
			best_index = index;
			fprintf('direct = %d best_index =%d error_sum1 = %d error_sum2 =%d\n',direct,best_index,error_sum1,error_sum2);
		end
	end
end


best_index
best_dim
direct
count = 0;
load hw2_test.dat
B = hw2_test
for ttt = 1:size(B,1)
	if( direct* sign(B(ttt,best_dim)-best_index) ~= B(ttt,size(B,2)))
		count = count+1
	end
end
Eout = count/size(B,1)

