train_data = load('hw4_train.dat');
test_data = load('hw4_test.dat');

Xtrain = train_data(1:120,1:2);	
Ytrain = train_data(1:120,3);
Xvalid = train_data(121:200,1:2);
Yvalid = train_data(121:200,3);

Xout = test_data(:,1:2);
Yout = test_data(:,3);

Xtrain = extend(Xtrain);
Xvalid = extend(Xvalid);
Xout = extend(Xout);


Z = 2:-1:-10;
Eval_min = inf;
Eval_history = [];

for z = Z
	lambda = power(10,z);
	w = inv (lambda* eye(size(Xtrain,2)) + Xtrain'*Xtrain) *Xtrain'* Ytrain;
	Eval = count_error(w,Xvalid,Yvalid);
	if(Eval_min > Eval)
		Eval_min = Eval ;
		min_index = z ;
		wmin = w;
	end
	Eval_history = [Eval_history Eval];
end

Eout = count_error(wmin,Xout,Yout);

plot(Z,Eval_history);
axis([-10,2,0,0.5]);
xlabel('log base 10 of labmda');
ylabel('Evalid');
fprintf('lambda with Min Evalid = %d , Eout = %d \n',power(10,min_index),Eout);
