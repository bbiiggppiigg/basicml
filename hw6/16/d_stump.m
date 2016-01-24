function [best_s,best_i,best_theta,curret_E] = d_stump(u,Xtrain,Ytrain)
  N = size(Xtrain,1);
  d = size(Xtrain,2);

  curret_E = inf;
  for  i =1:d
    Xt = sortrows(Xtrain,i);
    a = -inf;
    for j = 1 : N
      theta = (a + Xt(j,i)) / 2;
      E1 = test_stump(1,i,theta,Xtrain,Ytrain,u);
      E2 = test_stump(-1,i,theta,Xtrain,Ytrain,u);
      if(E1 < curret_E)
        curret_E = E1;
        best_s = 1;
        best_i = i;
        best_theta = theta;
      end
      if(E2 < curret_E)
        curret_E = E2;
        best_s = -1;
        best_i = i;
        best_theta = theta;
      end
      a = Xt(j,i);
    end
  end
