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
Eins = [];
Eouts = [];
ks = 1:2:9;
for k = ks
  label = knn_predict(Xtrain,Xtrain,Ytrain,k);
  error = count_error(Ytrain,label);
  fprintf('k= %d Ein = %f\n',k,error );
  Eins = [Eins error];
end

for k = ks
  label = knn_predict(Xtest,Xtrain,Ytrain,k);
  error = count_error(Ytest,label);
  fprintf('k= %d Eout  = %f\n',k,error );
  Eouts = [Eouts error];
end
