trainset = load('hw8_train.dat.txt');
testset = load('hw8_test.dat.txt');
Ntrain = size(trainset,1);
dtrain = size(trainset,2)-1;

Ntest = size(testset,1);
dtest = size(testset,2)-1;

Xtrain = trainset(:,1:dtrain);
Ytrain = trainset(:,dtrain+1);
Xtest = testset(:,1:dtest);
Ytest = testset(:,dtest+1);
rs = [0.001 0.1 1 10 100]
Eouts = [];
Eins = [];
for r = rs
  label = guinform(Xtrain,Xtrain,Ytrain,r);
  error = count_error(Ytrain,label);
  fprintf('r = %f , Ein = %f\n' , r , error);
  Eins = [Eins error];
end


for r = rs
  label = guinform(Xtest,Xtrain,Ytrain,r);
  error = count_error(Ytest,label);
  fprintf('r = %f , Eout = %f\n' , r , error);
  Eouts = [Eouts error];
end
