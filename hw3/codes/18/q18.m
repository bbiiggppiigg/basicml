tt = load('hw3_train.dat');
row_size = size(tt,1);
feature_size = size(tt,2)-1;
X = tt(:,1:feature_size)';
Y =tt(:,feature_size+1);

err = @(y,w,x) (-y*x)/(1+exp(y*w'*x))
w = zeros(feature_size,1);
for t = 1:2000
	grad = zeros(feature_size,1);
	 for i = 1 : row_size
		grad = grad+err(Y(i,1),w,X(:,i));
	end 
	delta = grad/row_size;
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