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

cs = [0.0001 0.01 0.1 1 10];
option3 = [ 
	'-s 0 -t 2  -c 0.001 -g 100 -h 0';
	'-s 0 -t 2  -c 0.01  -g 100 -h 0';
	'-s 0 -t 2  -c 0.1   -g 100 -h 0';
	'-s 0 -t 2  -c 1     -g 100 -h 0';
	'-s 0 -t 2  -c 10    -g 100 -h 0'
];
predictions = [];
models = [];
sv_index = -1;
distances = [];

for i =1:5
	model = svmtrain(Y,X,option3(i,:));
	w = (model.sv_coef)' * model.SVs;
	b = -model.rho;
	for j = 1 : size(model.sv_indices,1)
		if(abs(model.sv_coef(j))<cs(i))
			sv_index = j;
			break;
		end
	end
	[predict_label accuracy des_value] = svmpredict(Y(sv_index),X(sv_index,:),model);
	distances = [distances abs(des_value) / norm(w,2)] ;
end

plot(0:1:4,distances);
xlabel('log based 10 of r');
ylabel('distance between free support vector and hyperplane');
