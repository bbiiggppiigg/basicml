E = @(u,v) exp(u)+exp(2*v)+exp(u*v) + u^2 - 2*u*v+ 2*v^2 - 3*u-2*v
dEdu =@(u,v) exp(u)+v*exp(u*v)+2*u-2*v-3;
dEdv= @(u,v) 2*exp(2*v)+u*exp(u*v)-2*u+4*v-2;
eta = 0.01;
u = 0;
v = 0;
for i =1 : 5
fprintf('u= %d, v =%d du = %d dv = %d \n',u,v,dEdu(u,v),dEdv(u,v));
new_u = u - eta*dEdu(u,v);
new_v = v - eta*dEdv(u,v);
u = new_u;
v = new_v;
end
fprintf('u= %d, v =%d du = %d dv = %d \n',u,v,dEdu(u,v),dEdv(u,v));
E(u,v)
