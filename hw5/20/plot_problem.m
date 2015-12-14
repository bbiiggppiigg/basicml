function [] = plot_problem(X,Y);

other_index = [];
total_index = 1:size(Y,1);
for i = 1 : total_index
	if(Y(i)~=1)
		other_index = [other_index i];
	end
end
support_index = setdiff(total_index,other_index);
plot(X(support_index,1),X(support_index,2),'o');
hold on
plot(X(other_index,1),X(other_index,2),'x');

xlabel('intensity');
ylabel('symetry');