function [error_rate] = test_error(X,Y,w,b)
	Z = X*w';
	error_count = 0;
	for i = 1 : size(Z,1)
		if(sign(Z(i,1)+b)~=Y(i,1))
			error_count = error_count+1;
		end
	end	
	error_rate = error_count / size(Z,1);
