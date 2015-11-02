f = @(N) 4096 * power(N,10) * exp(-N/3200)-0.05
f_bar = @(N) 4096 * (10*power(N,9)*exp(-N/3200)-power(N,10)*exp(-N/3200)/3200)
x = 400000
 
for i = 1:1:20
	new_x = x-  f(x)/f_bar(x);
	fprintf('x = %d\n',new_x);
	if(abs(new_x-x)<1e3)
		break;
	end
	x = new_x;
end