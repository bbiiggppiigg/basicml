function [Yout] = gen_label(Y,value)
	Yout = Y;
	for i = 1 : size(Y,1)
		if(Y(i,1)==value)
			Yout(i,1) = 1;
		else
			Yout(i,1) = -1;
		end
	end