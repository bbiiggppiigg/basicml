function [Ein] = test_error(beta,Xtrain,r,Xtest,Ytest)
  N = size(Xtrain,1);
  T = size(Xtest,1);
  Y2 = [];
  error_count = 0;
  rbf = @(X1,X2,r) exp(-r*norm(X1-X2,2)^2);

  for t = 1:T
    y = 0;
    for i= 1 : N
      y = y + beta(i)*rbf(Xtrain(i,:),Xtest(t,:),r);
    end
    Y2 = [Y2  y];
    if(Ytest(t)~=sign(y))
      error_count = error_count+1;
    end
  end
  Ein = error_count /T;
%{
  error_count = 0;
  for t = 1 : T
    if(sign(Y2(t))~=Ytest(t))
      error_count = error_count +1;
    end
  end
  Ein2 = error_count /T;

  Ein
  Ein2
%}
