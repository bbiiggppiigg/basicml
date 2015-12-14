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
vote = zeros(1,5);
value_range = 1:size(X,1);
for t = 1:100
	indices = randsample(size(X,1),1000);
	Xvalid = X(indices,:);
	Yvalid = Y(indices,:);
	Xtrain = X(setdiff(value_range,indices),:);
	Ytrain = Y(setdiff(value_range,indices),:);
	max_index = -1;
	max_accuracy = -1;
	for i =1:5
		model = svmtrain(Ytrain,Xtrain,option3(i,:));
		w = (model.sv_coef)' * model.SVs;
		b = -model.rho;
		[predicted_label accuracy decision_values] = svmpredict(Yvalid,Xvalid,model);
		if(accuracy(1) > max_accuracy)
			max_accuracy = accuracy(1);
			max_index = i;
		end
	end
	vote(max_index) = vote(max_index)+1;
end
plot(0:1:4,vote);
xlabel('log based 10 of r');
ylabel('Time selected');
