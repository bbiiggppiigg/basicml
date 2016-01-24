function [label] = knn_predict(Xpredict,X,Y,k);

  N = size(X,1);
  Npredict =size(Xpredict,1);
  Z = pdist2(Xpredict,X);
  label = [];
  for i = 1:Npredict
    tmp = [];
    for j =1:N
      %if(i==j) continue; end
      tmp = [tmp ;[Z(i,j) Y(j,1)] ];
    end
    knns = sortrows(tmp,1);
    label = [label ;sign(sum(knns(1:k,2)))];
  end
