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
  thetas =[thetas best_theta];
  u_s = [u_s sum(u)];
  u(wrong_index) = u(wrong_index) * dt;
  u(right_index) = u(right_index) /dt;

end

plot(1:1:300,u_s);
xlabel('t');
ylabel('sum u_n^T');
u_s(2)
u_s(300)
