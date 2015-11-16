f = @(x)  sign(x(1)^2+x(2)^2-0.6)
error_rate_sum = 0;
error_history = [];
for t = 1:1000
	X = rand(1000,1) * 2 -1;
	Y = rand(1000,1) *2  -1;
	D = [X Y];
	Z = [];
	for i = 1:1000
		z = f(D(i,:));
		if(rand()<=0.1)
			z = -z;
		end
		Z = [Z ;z];
	end
	D = [ones(1000,1) D];
	W = inv(D'*D)*D'*Z;
	OUT = D*W;
	err = 0;
	for i = 1:1000
		if(sign(Z(i))~=sign(OUT(i)))
			err= err+1;
		end
	end
	error_rate_sum = error_rate_sum+err/1000;
	error_history = [error_history; err/1000];
end
histogram(error_history)
error_rate_sum/1000
