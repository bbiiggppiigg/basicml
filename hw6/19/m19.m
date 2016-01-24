in = load('hw2_lssvm_all.dat.txt');
N = size(in,1);
d = size(in,2);
X = in(:,1:d-1);
Y = in(:,d);
Xtrain = X(1:400,:);
Ytrain = Y(1:400,:);
Xtest = X(401:N,:);
Ytest = Y(401:N,:);
M = 400;

K = zeros(M,M);

rbf = @(X1,X2,r) exp(-r*norm(X1-X2,2)^2);
rs = [32 2 0.125];
lambdas = [0.001 1 1000];
for i = 1:9
  rs_index = ceil(i/3);
  lambda_index = mod(i,3);
  if(lambda_index==0) lambda_index = 3; end

  for i=1:M
    for j=1:M
      K(i,j) = rbf(Xtrain(i,:),Xtrain(j,:),rs(rs_index));
    end
  end

  O = inv(lambdas(lambda_index)*eye(M)+K);
  beta = O*Ytrain;

  Ein = test_error(beta,Xtrain,rs(rs_index),Xtrain,Ytrain);

  fprintf('rs = %d\tlambda_index = %d\tEin = %d\n',rs(rs_index),lambdas(lambda_index),Ein);
end
