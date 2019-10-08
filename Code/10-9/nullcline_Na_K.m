C = 1;
I = 20;
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


V = linspace(-80, 20, T);

n = (I-g_L*(V-E_L)-g_Na*p_inf(V,Vm_half,k_m).*(V-E_Na))./(g_K*(V-E_K));

figure; plot(V,n,V,p_inf(V,Vn_half,k_n));

function p = p_inf(V,V_half,k)

  p=1./(1+exp((V_half-V)/k));

end
