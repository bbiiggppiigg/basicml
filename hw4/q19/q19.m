train_data = load('hw4_train.dat');
test_data = load('hw4_test.dat');
N = 200;
Z = 2:-1:-10;

Ecv_min = inf;
Ecv_history = [];
for z = Z
	lambda = power(10,z);
	Ecv = 0;
	for i = 0:1:4
		s = i*40+1;
		d = i*40+40;
		Xvalid = train_data(s:d,1:2);
		Yvalid = train_data(s:d,3);
		if(s ==1 )
			Xtrain = train_data(41:200,1:2);
			Ytrain = train_data(41:200,3);
		else 
			if(d == 200)
				Xtrain = train_data(1:160,1:2);
				Ytrain = train_data(1:160,3);
			else
				Xtrain = [train_data(1:s-1,1:2); train_data(d+1:N,1:2)];
				Ytrain = [train_data(1:s-1,3); train_data(d+1:N,3)];
			end
		end	
		
		Xtrain = extend(Xtrain);
		Xvalid = extend(Xvalid);
		
		w = inv (lambda* eye(size(Xtrain,2)) + Xtrain'*Xtrain) *Xtrain'* Ytrain;
		Ecv = Ecv+count_error(w,Xvalid,Yvalid);
	end
	Ecv_history = [Ecv_history Ecv/5];
	if(Ecv_min > Ecv)
		Ecv_min = Ecv ;
		min_index = z ;
		wmin = w;
	end
end

fprintf('lambda with min Ecv = %d , Ecv = %d\n',power(10,min_index),Eval_min);
plot(Z,Ecv_history);
axis([-10 2 0  0.3]);
xlabel('log base 10 of labmda');
ylabel('Ecv');
