train_data = load('hw4_train.dat');
test_data = load('hw4_test.dat');
X = train_data(:,1:2);	
Y = train_data(:,3);
Xout = test_data(:,1:2);
Yout = test_data(:,3);
X = extend(X);
Xout = extend(Xout);

Z = 2:-1:-10;
Ein_min = inf;
min_index =0;
Ein_history = [];
wmin = zeros(2,1);

for z = Z
	lambda = power(10,z);
	w = inv (lambda* eye(size(X,2)) + X'*X) *X'* Y;
	Ein = count_error(w,X,Y);
	if(Ein_min > Ein)
		Ein_min = Ein ;
		min_index = z ;
		wmin = w;
	end
	Ein_history = [Ein_history Ein];
end

Eout = count_error(wmin,Xout,Yout);

plot(Z,Ein_history,'-');
axis([-10,2,0,0.3]);
xlabel('log base 10 of labmda');
ylabel('Ein');
fprintf('lambda with Min Ein = %d , Eout = %d \n',power(10,min_index),Eout);
