Ein = [];
Eout = [];
for tmp = 1:2000
	X = -1:(2/19):1;
	Y = zeros(1,20);

	for i = 1:1:20
		if rand(1,1) <= 0.8
			Y(1,i) = sign(X(1,i));
		else
			Y(1,i) = -sign(X(1,i));
		end
	end

	s  =0; 
	direct =0;
	error_current = 20;
	best_o =0;
	for o = -1-(1/19):(2/19):1+(1/19)
		error_sum1 = 0;
		error_sum2 = 0;
		for i = 1:1:20
			index = -1+(i-1)*(2/19);
			if index > o 
				if(Y(1,i) > 0)
					error_sum2=error_sum2+1;
				else
					error_sum1=error_sum1+1;
				end
			else
				if(Y(1,i) < 0 )
					error_sum2=error_sum2+1;
				else
					error_sum1=error_sum1+1;
				end
			end
		end
		if(error_sum1<error_current)
			error_current = error_sum1;
			best_o = o;
			direct = 1;
		end
		if(error_sum2<error_current)
			error_current = error_sum2;
			best_o = o;
			direct = -1;
		end
	end
	Ein = [Ein error_current/20];
	Eout = [Eout (0.5+0.3*direct*(abs((best_o))-1))];
end
fprintf('mean of Ein = %d\n',mean(Ein));

%histogram(Ein);
%xlabel('Ein');
%ylabel('Count');
fprintf('mean of Eout = %d\n',mean(Eout));
histogram(Eout);
xlabel('Eout');
ylabel('Count');
