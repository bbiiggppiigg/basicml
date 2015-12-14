data = load ('2.in');
X = data(:,1:2);
Y = data(:,3);

K = @(x1,x2) (1 + x1*x2')^2

p = -1*ones(7,1);
Q = zeros(7,7);
for i = 1:7
	for j = 1: 7
		Q(i,j) = Y(i,1)*Y(j,1)*K(X(i,:),X(j,:))
	end
end
A = [-eye(7,7)];
c = zeros(7,1);
Aeq = Y(:,1)';
x = quadprog(Q,p,A,c,Aeq,0);

index = 2;
b = Y(index,1);
w = zeros(7,1);

alpha = x;
w(1,1) = Y(index,1);
for i = 1:7
	w = w + [- alpha(i) * Y(i,:) * K(X(i,:),X(index,:));
			alpha(i)*Y(i); 
			 2*alpha(i)*Y(i)*X(i,1);
			 2*alpha(i)*Y(i)*X(i,2);
			 alpha(i)*Y(i)*X(i,1)^2;
			 alpha(i)*Y(i)*X(i,1)*X(i,2);
			 alpha(i)*Y(i)*X(i,2)^2];
end
9*w'