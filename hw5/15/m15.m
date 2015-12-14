addpath('~/libsvm-3.20/matlab/')
in = load('features.train.dat');
X = in(:,2:3);
Yin = in(:,1);
Y = Yin;
n = size(in,1);
Y = gen_label(Yin,0)


option3 = [ 
	'-s 0 -t 0  -c 0.000001 -h 0 ';
	'-s 0 -t 0  -c 0.0001   -h 0 ';
	'-s 0 -t 0  -c 0.01     -h 0 ';
	'-s 0 -t 0  -c 1        -h 0 ';
	'-s 0 -t 0  -c 100      -h 0 '
];

weight_array = [];
for i = 1:5
model = svmtrain(Y,X,option3(i,:));
w = (model.sv_coef)' * model.SVs;
b = -model.rho;
weight_array = [ weight_array norm(w,2) ];
end

plot(-6:2:2,weight_array);
xlabel('log based 10 of C');
ylabel('norm of w');

