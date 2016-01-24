function [E wrong_index right_index] = test_stump(s,i,theta,X,Y,u)
  error_count = 0;
  wrong_index = [];
  right_index =[];
  for t = 1 : size(X,1)
    if( sign(X(t,i) - theta) * sign(s) ~= sign(Y(t) ))
      error_count = error_count+1;
      wrong_index = [wrong_index ; t];
    else
      right_index = [right_index; t];
    end
  end
  E = sum(u(wrong_index));
