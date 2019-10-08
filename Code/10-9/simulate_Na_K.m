C = 1;
I = 0;
E_L = -78;
E_Na = 60;
E_K = -90;
Vn_half = -45;
g_L= 8;
g_Na = 20;
g_K = 10;
Vm_half = -20;
k_m = 15;
k_n = 5;
dt = 0.1;
tau = 1;
t = 0:dt:30;
T = length(t);
V = ones(1,T)*(-60);
n = zeros(1,T);


for i=1:T-1

  if (i>T/2)
    I = 40;
  else
    I = 0;
  end

  V(i+1) = V(i) + (I-g_L*(V(i)-E_L)-g_Na*p_inf(V(i),Vm_half,k_m)*(V(i)-E_Na)-g_K*n(i)*(V(i)-E_K))*dt/C;
  n(i+1) = n(i) + (p_inf(V(i),Vn_half,k_n)-n(i))*dt/tau;

end

figure, plot(t,V);

function p = p_inf(V,V_half,k)

  p=1./(1+exp((V_half-V)/k));

end
