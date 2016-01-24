train = load('hw2_adaboost_train.dat.txt');
test = load('hw2_adaboost_test.dat.txt');
N = size(train,1);
d = size(train,2)-1;
Xtrain = train(:,1:d);
Ytrain = train(:,d+1);
u = 1/N*ones(N,1);
s_s = [];
i_s = [];
eps_s = [];
thetas= [];
alphas = [];
Einus = [];
u_s = [];
for t = 1 : 300
t
  [best_s,best_i,best_theta,curret_E] = d_stump(u,Xtrain,Ytrain);
  [E wrong_index right_index] = test_stump(best_s,best_i,best_theta,Xtrain,Ytrain,u);
  Einus = [Einus E];
  eps = sum(u(wrong_index)) / sum(u);
  dt = sqrt((1-eps)/eps);
  alphas = [alphas log(dt)];
  s_s = [s_s best_s];
  i_s = [i_s best_i];
  eps_s = [eps_s eps];
  u_s = [u_s ; u'];
  thetas =[thetas best_theta];
  u(wrong_index) = u(wrong_index) * dt;
  u(right_index) = u(right_index) /dt;
end

g= @(s,i,theta,X) sign(s*(X(i)-theta));
Ein = [];
for T = 1: 300
  error_count = 0;
  for i = 1:N
    weighted_sum = 0;
    for t = 1 : T
      weighted_sum = weighted_sum + alphas(t)*g(s_s(t),i_s(t),thetas(t),Xtrain(i,:));
    end
    if(sign(weighted_sum)~=sign(Ytrain(i)))
      error_count = error_count+1;
    end
  end
  Ein = [Ein error_count/N];
end
plot(1:1:300,Ein);
xlabel('t');
ylabel('Ein(Gt)');
%{
fid = fopen('m14.txt','wt');
for ii = 1:size(u_s,1)
  for jj  = 1 : size(u_s,2)
    fprintf(fid,'%20.18f\t',u_s(ii,jj));
  end
  fprintf(fid,'\n');
end
fclose(fid)
%}
