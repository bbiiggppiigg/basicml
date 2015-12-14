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
Etrain_min = inf;
Etrain_history = [];

for z = Z
	lambda = power(10,z);
	w = inv (lambda* eye(size(Xtrain,2)) + Xtrain'*Xtrain) *Xtrain'* Ytrain;
	Etrain = count_error(w,Xtrain,Ytrain);
	if(Etrain_min > Etrain)
		Etrain_min = Etrain ;
		min_index = z ;
		wmin = w;
	end
	Etrain_history = [Etrain_history Etrain];
end
Eval = count_error(wmin,Xvalid,Yvalid);
Eout = count_error(wmin,Xout,Yout);

plot(Z,Etrain_history);
axis([-10,2,0,0.4]);
xlabel('log base 10 of labmda');
ylabel('Etrain');
fprintf('lambda with Min Etrain = %d , Eout = %d \n',power(10,min_index),Eout);
