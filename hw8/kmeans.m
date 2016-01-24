function [error] = kmeans(X,k);
  N = size(X,1);
  samples = randsample(N,k);
  d = size(X,2);
  u = [];
  for i = 1 : k
    u = [u ;X(samples(i),:)];
  end
  old_out  = zeros(N,1);

  for t = 1 : 1000000
    z = pdist2(X,u);
    out = [];
    for i =1 : N
      tmp = [];
      for j = 1 : k
        tmp = [tmp; [z(i,j) j] ];
      end
      nns = sortrows(tmp,1);
      out = [out ; nns(1,2)];
    end
    if(old_out == out)
      %fprintf('t = %d\n',t);
      break;
    end
    if(t==10000)
      fprintf('ggsmd\n');
    end
    old_out = out;
    u = zeros(k,d);
    counter = zeros(1,k);
    for i =1 : N
      u(out(i),:) = u(out(i),:) + X(i,:);
      counter(out(i)) = counter(out(i))+1;
    end
    for i = 1 : k
      u(i,:) = u(i,:) / counter(k);
    end
  end
  error = 0;
  for n = 1 : N
    for m = 1 : k
      if(out(n)==m)
        error = error + norm(X(n,:)-u(m,:),2)^2;
      end
    end
  end
  error = error / N;
