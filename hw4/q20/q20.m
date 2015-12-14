train_data = load('hw4_train.dat');
test_data = load('hw4_test.dat');

X = train_data(:,1:2);	
Y = train_data(:,3);
Xout = test_data(:,1:2);
Yout = test_data(:,3);

X = extend(X);
Xout = extend(Xout);

z = -8;
lambda = power(10,z);
w = inv (lambda* eye(size(X,2)) + X'*X) *X'* Y;

Ein = count_error(w,X,Y);
Eout = count_error(w,Xout,Yout) ;

fprintf('Ein = %d , Eout = %d\n',Ein,Eout);