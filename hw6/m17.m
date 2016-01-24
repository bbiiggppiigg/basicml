train = load('hw2_adaboost_train.dat.txt');
test = load('hw2_adaboost_test.dat.txt');
N = size(train,1);
d = size(train,2)-1;
Xtrain = train(:,1:d);
Ytrain = train(:,d+1);
Xtest = test(:,1:d);
Ytest = test(:,d+1);
M = size(test,1);
u = 1/N*ones(N,1);
s_s = [];
i_s = [];
eps_s = [];
thetas= [];
alphas = [];
Einus = [];
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
  u(wrong_index) = u(wrong_index) * dt;
  u(right_index) = u(right_index) /dt;
end

Eout = [];
for t = 1: 300
  Eout= [Eout test_stump(s_s(t),i_s(t),thetas(t),Xtest,Ytest,1/M*ones(M,1))];
end
plot(1:1:300,Eout);
xlabel('t');
ylabel('Eout');
Eout(1)
