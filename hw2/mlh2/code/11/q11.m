clf
h_a = @(a,x) sign(abs(mod(a*x,4)-2) -1) 

X = -4:0.01:4;
Y1 = [];
Y2 = [];
Y3 = [];
for i = X
	Y1 = [Y1 h_a(1,i)];
	Y2 = [Y2 h_a(4,i)];
	Y3 = [Y3 h_a(2,i)];
end
hold on
%plot(X,Y1);
%plot(X,Y2);
plot(X,Y3);
hold off