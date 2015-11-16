tt = load('hw3_train.dat');
row_size = size(tt,1);
feature_size = size(tt,2)-1;
X = tt(:,1:feature_size)';
Y =tt(:,feature_size+1);

err = @(y,w,x) (-y*x)/(1+exp(y*w'*x))
w = zeros(feature_size,1);
random_index = randperm(row_size);

for t = 1:2000
	grad = err(Y(random_index(1,mod(t,row_size)+1)),w,X(:,mod(t,row_size)+1));
	delta = grad;
	w = w-0.001*delta;
end

tt = load('hw3_test.dat');
row_size = size(tt,1);
feature_size = size(tt,2)-1;
X = tt(:,1:feature_size)';
Y =tt(:,feature_size+1);

count = 0;
for i = 1:row_size
	if(sign(w'*X(:,i))~=sign(Y(i,1)))
		count =count+1;
	end
end
w
count / row_size
