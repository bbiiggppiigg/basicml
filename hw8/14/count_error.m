function [count] = count_error(predict,label)
  N = size(predict,1);
  count =0;
  for i = 1 : N
    if(sign(predict(i,1))~=sign(label(i,1)))
      count=count+1;
    end
  end
  count = count/ N;
