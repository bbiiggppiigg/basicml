function [label ] = guinform(Xpredict, Xtrain, Ytrain,gamma)
  label = [];
  Npredict =size(Xpredict,1);
  N = size(Xtrain,1);
  for i = 1 : Npredict
    count = 0;
    for j = 1 : N
      count = count + Ytrain(j,1) * exp(-gamma*norm(Xtrain(j,:)-Xpredict(i,:),2)^2);
    end
    label = [label ; sign(count) ];
  end
