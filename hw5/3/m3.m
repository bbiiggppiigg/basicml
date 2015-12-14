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
alpha = quadprog(Q,p,A,c,Aeq,0);
for i = 1:size(alpha,1)
	if(norm(alpha(i))>0.00001)
		fprintf('(%d,%d)\t%d\n',X(i,1),X(i,2),Y(i));
	end
end
