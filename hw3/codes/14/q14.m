f = @(x)  sign(x(1)^2+x(2)^2-0.6)
g = @(x) [1 x(1) x(2) x(1)*x(2) x(1)*x(1) x(2)*x(2)]
error_rate_sum = 0;
Ws = [];
for t = 1:1000
	X = rand(1000,1) * 2 -1;
	Y = rand(1000,1) *2  -1;
	D = [X Y];
	Z = [];
	G = [];
	for i = 1:1000
		z = f(D(i,:));
		if(rand()<=0.1)
			z = -z;
		end
		Z = [Z ;z];
		G = [G; g(D(i,:))];
	end
	
	W = inv(G'*G)*G'*Z;
	OUT = G*W;
	err = 0;
	for i = 1:1000
		if(sign(Z(i))~=sign(OUT(i)))
			err= err+1;
		end
	end
	Ws = [Ws  W];
	error_rate_sum = error_rate_sum+err/1000;
end
error_rate_sum/1000
weight = [];
for i = 1:6
	weight = [weight ; sum(Ws(i,:))/1000 ];
end
histogram(Ws(4,:));
weight(4)
