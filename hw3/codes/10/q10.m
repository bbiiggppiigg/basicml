E = @(u,v) exp(u)+exp(2*v)+exp(u*v) + u^2 - 2*u*v+ 2*v^2 - 3*u-2*v;
gE = @(u,v)[exp(u)+v*exp(u*v)+2*u-2*v-3;  2*exp(2*v)+u*exp(u*v)-2*u+4*v-2; ];
HE = @(u,v)[ exp(u)+v^2*exp(u*v)+2 exp(u*v)+v*u*exp(u*v)-2;exp(u*v)+v*u*exp(u*v)-2 4*exp(2*v)+u^2*exp(u*v)+4];

x = [0 ; 0];
for i =1 : 5
	dx =  - inv(HE(x(1),x(2)))*gE(x(1),x(2));
	fprintf('u =%d , v= %d ,du = %d v = %d\n',x(1),x(2),dx(1),dx(2));
	x = x+dx;
end
E(x(1),x(2))
