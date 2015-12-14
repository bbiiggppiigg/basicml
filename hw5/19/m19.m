addpath('~/libsvm-3.20/matlab/')
in = load('features.train.dat');
out = load('features.test.dat');
X = in(:,2:3);
Yin = in(:,1);
Y = Yin;
Xout = out(:,2:3);
n = size(in,1);
Ein = [];
Eout = [];
alphas = [];

Y = gen_label(Yin,0);
Yout = gen_label(out(:,1),0);

rs = [1 10 100 1000 10000];
option3 = [ 
	'-s 0 -t 2  -c 0.1 -g 1     -h 0 ';
	'-s 0 -t 2  -c 0.1 -g 10    -h 0 ';
	'-s 0 -t 2  -c 0.1 -g 100   -h 0 ';
	'-s 0 -t 2  -c 0.1 -g 1000  -h 0 ';
	'-s 0 -t 2  -c 0.1 -g 10000 -h 0 '
];
Eout = [];
for i =1:5
	model = svmtrain(Y,X,option3(i,:));
	w = (model.sv_coef)' * model.SVs;
	b = -model.rho;
	[b a c]  = svmpredict(Yout,Xout,model);
	Eout = [Eout 1-a(1)/100];
end

plot(0:1:4,Eout);
xlabel('log based 10 of r');
ylabel('Eout');
