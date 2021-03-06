f = @(x)  sign(x(1)^2+x(2)^2-0.6)
g = @(x) [1 x(1) x(2) x(1)*x(2) x(1)*x(1) x(2)*x(2)]
error_rate_sum = 0;
Ws = [];
error_history = [];
for t = 1:1000
	X = rand(1000,1) * 2 -1;
	Y = rand(1000,1) *2  -1;
	Xout = rand(1000,1) * 2 -1;
	Yout = rand(1000,1) *2  -1;
	
	D = [X Y];
	Dout = [Xout Yout];
	Z = [];
	Zout = [];
	G = [];
	Gout = [];
	for i = 1:1000
		z = f(D(i,:));
		zout = f(Dout(i,:));
		if(rand()<=0.1)
			z = -z;
		end
		if(rand()<=0.1)
			zout = -zout;
		end
		Zout = [Zout ; zout];
		Z = [Z ;z];
		G = [G; g(D(i,:))];
		Gout = [Gout; g(Dout(i,:))];
	end
	
	W = inv(G'*G)*G'*Z;
	OUT = Gout*W;
	err = 0;
	for i = 1:1000
		if(sign(Zout(i))~=sign(OUT(i)))
			err= err+1;
		end
	end
	Ws = [Ws  W];
	error_rate_sum = error_rate_sum+err/1000;
	error_history = [error_history ; err/1000];
end
error_rate_sum/1000

histogram(error_history);