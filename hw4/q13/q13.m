train_data = load('hw4_train.dat');
test_data = load('hw4_test.dat');

lambda = 11.26;
X = train_data(:,1:2);	
X = extend(X);

Y = train_data(:,3);

Xout = test_data(:,1:2);
Xout = extend(Xout);

Yout = test_data(:,3);
w = inv (X'*X+lambda* eye(size(X,2))) *X'* Y;

Ein = count_error(w,X,Y);
Eout = count_error(w,Xout,Yout);
fprintf('Ein = %d , Eout =%d\n',Ein,Eout);
