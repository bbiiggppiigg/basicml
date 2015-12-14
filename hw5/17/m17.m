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

Y = gen_label(Yin,8);


option3 = [ 
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 0.000001 -h 0 ';
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 0.0001   -h 0 ';
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 0.01     -h 0 ';
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 1        -h 0 ';
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 100      -h 0 '
];


for i =1 : 5
	model = svmtrain(Y,X,option3(i,:));
	w = (model.sv_coef)' * model.SVs;
	b = -model.rho;
	total_alpha = (model.sv_coef)'*Y(model.sv_indices,:);
	alphas = [alphas total_alpha];
end

plot(-6:2:2,alphas);
xlabel('log based 10 of C');
ylabel('sigma_n alpha_n');