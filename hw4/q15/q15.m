train_data = load('hw4_train.dat');
test_data = load('hw4_test.dat');

X = train_data(:,1:2);	
Y = train_data(:,3);

Xout = test_data(:,1:2);
Yout = test_data(:,3);
X = extend(X);
Xout = extend(Xout);


Z = 2:-1:-10;
Eout_min = inf;
min_index =0;
Eout_history = [];

for z = Z
	lambda = power(10,z);
	w = inv (lambda* eye(size(X,2)) + X'*X) *X'* Y;
	Eout = count_error(w,Xout,Yout);
	if(Eout_min > Eout)
		Eout_min = Eout;
		min_index = z;
		wmin = w;
	end
	Eout_history = [Eout_history Eout];
end


plot(Z,Eout_history,'-');
axis([-10,2,0,0.3]);
xlabel('log base 10 of labmda');
ylabel('Eout');
fprintf('lambda with Min Eout = %d , Eout = %d \n',power(10,min_index),Eout_min);
