trainset = load('hw8_nolabel_train.dat.txt');
Ntrain = size(trainset,1);
dtrain = size(trainset,2);
Xtrain = trainset(:,1:dtrain);


ks  = [2  4 6 8 10];
for k = ks
  error = 0 ;
  for t = 1 : 500
    error = error + kmeans(Xtrain,k);
  end
  error = error /500;
  fprintf(' k = %d , error = %f\n' , k ,error);
end
