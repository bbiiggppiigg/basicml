phi1 = @(x) x(2)^2 - 2 * x(1) + 3;
phi2 = @(x) x(1)^2 - 2 * x(2) - 3;
trans = @(x) [ phi1(x) phi2(x) ];
data = load ('2.in');
X = data(:,1:2);
Y = data(:,3);
Q = zeros(3,3);
Q (2,2) = 1;
Q(3,3 ) = 1;
p = zeros(3,1);
A = [];
for i = 1:7
	A = [A; Y(i,1)*[1 trans(X(i,:))] ];
end
c = ones(7,1);

x = quadprog(Q,p,-A,-c);

