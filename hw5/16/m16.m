addpath('~/libsvm-3.20/matlab/')
in = load('features.train.dat');
X = in(:,2:3);
Yin = in(:,1);
Y = Yin;
n = size(in,1);
Ein = [];
alphas = [];


option3 = [ 
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 0.000001 -h 0 ';
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 0.0001   -h 0 ';
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 0.01     -h 0 ';
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 1        -h 0 ';
	'-s 0 -t 1 -d 2 -g 1 -r 1 -c 100      -h 0 '
];



for i = 1:5
	Y = gen_label(Yin,8);
	model = svmtrain(Y,X,option3(i,:));
	w = (model.sv_coef)' * model.SVs;
	b = -model.rho;
	[b a c ] = svmpredict  (Y,X,model); 
	Ein = [Ein 1-a(1)/100 ];
end

plot(-6:2:2,Ein)
xlabel('log based 10 of C');
ylabel('Ein');
