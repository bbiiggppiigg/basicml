dvc = 50
delta = 0.05

mh = @(N) power(N,50)
f1  = @(N) sqrt((8/N)*(50*log(2*N)+log(80)))
f2 = @(N) sqrt((16/N)*(log(2)+50*log(N)-log(0.05)/2))
f3 = @(N) sqrt((2/N)*(log(2)+51*log(N)))+sqrt(2/N*log(20))+1/N
f4 = @(N) 1/N + sqrt(1/power(N,2)+(log(120)+50*log(2*N))/N)
f5 = @(N)  1/(N-2) + sqrt(1/power(N-2,2)+(log(20)+50*log(N))/(N-2))

X = 0:0.1:10;
Y1 = [];
Y2 = [];
Y3 = [];
Y4 = [];
Y5 = [];
for i = X
	Y1 = [Y1 f1(i)];	
	Y2 = [Y2 f2(i)];	
	Y3 = [Y3 f3(i)];	
	Y4 = [Y4 f4(i)];	
	Y5 = [Y5 f5(i)];	
end
hold on
plot(X,Y1);
plot(X,Y2);
plot(X,Y3);
plot(X,Y4);
plot(X,Y5);
legend('a','b','c','d','e');
hold off
N = 5

fprintf('f1(5)= %d\n',f1(N))
fprintf('f2(5)= %d\n',f2(N))
fprintf('f3(5)= %d\n',f3(N))
fprintf('f4(5)= %d\n',f4(N))
fprintf('f5(5)= %d\n',f5(N))

