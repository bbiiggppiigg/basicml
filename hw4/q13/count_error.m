function [ E ] = count_error (w , X , Y )
	E = 0 ;
	N = size(X,1);
	for t = 1 : N
		if(sign(X(t,:)*w)~=Y(t))
			E = E+1;
		end
	end
	E = E/N;
	