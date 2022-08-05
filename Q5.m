%% Formatting
clc
clear
close all
format shortg
%% Begin Question 5
A = [0 1;0 -0.1];
B = [0;0.1];
C = [1 0];
D = 0;

discrete_sys  = c2d(ss(A,B,C,D),1/1000,'tustin')

cont_roots_L = roots([1 314.2 98696])

discrete_roots_L = [exp(cont_roots_L(1)/1000);exp(cont_roots_L(2)/1000)]

L = place(discrete_sys.A',discrete_sys.C',discrete_roots_L)

cont_roots_K = roots([1 87.965 3947.8])

discrete_roots_K = [exp(cont_roots_K(1)/1000);exp(cont_roots_K(2)/1000)]

K = place(discrete_sys.A,discrete_sys.B,discrete_roots_L)

fig1 = figure('Position',[500 250 650 600]);
hold on
grid on
scatter(real(discrete_roots_K(1)),imag(discrete_roots_K(1)),'filled','b')
scatter(real(discrete_roots_K(2)),imag(discrete_roots_K(2)),'filled','b')
scatter(0,0,'+','k')
viscircles([0 0],1,'Color','k');
quiver(0,0,real(discrete_roots_K(1)),imag(discrete_roots_K(1)),1.005,'Color','k')
quiver(0,0,real(discrete_roots_K(2)),imag(discrete_roots_K(2)),1.005,'Color','k')
xlabel('Real')
ylabel('Imaginary')
title('Closed-Loop Discrete Roots for K')
saveas(fig1,'Disc_roots_k.png')

fig2 = figure('Position',[500 250 650 600]);
hold on
grid on
scatter(real(discrete_roots_L(1)),imag(discrete_roots_L(1)),'filled','b')
scatter(real(discrete_roots_L(2)),imag(discrete_roots_L(2)),'filled','b')
scatter(0,0,'+','k')
viscircles([0 0],1,'Color','k');
quiver(0,0,real(discrete_roots_L(1)),imag(discrete_roots_L(1)),1.005,'Color','k')
quiver(0,0,real(discrete_roots_L(2)),imag(discrete_roots_L(2)),1.005,'Color','k')
xlabel('Real')
ylabel('Imaginary')
title('Closed-Loop Discrete Roots for L')
saveas(fig2,'Disc_roots_l.png')

ss_dis = ss(discrete_sys.A-L'*discrete_sys.C-discrete_sys.B*K, L', -K, 0, 1/1000);
tf_dis = tf(ss_dis)

cont_sys = ss(A,B,C,D)

omega_n = 50;
zeta = 0.7;

L = place(A',C',roots([1,(2*2*pi*omega_n*zeta),(2*pi*omega_n)^2]));
L = L'

omega_n = 10;

% A_comp = A - B*K - L*C
syms s K1 K2

K = [K1 K2];
A_c = s*eye(2) - (A-B*K);
det_Ac = det(A_c);

k_pole = pole_calc(omega_n, zeta);
K_ = place(A, B, k_pole);
% K_ = [39476 878.62];
Bsys_ = ss(A-L*C-B*K_, L, -K_, 0);
figure
cl_con = feedback(cont_sys, Bsys_, +1); 
step(cl_con)
hold on 
cl_dis = feedback(discrete_sys,ss_dis , +1);
step(cl_dis)
title('Continuous and Discrete Response with Equivalent Compensator')
legend('Continuous', 'Discrete')


function pole_out = pole_calc(omega, zeta)
pole_out(1) = -omega*(zeta + sqrt(1 - zeta^2)*1i);
pole_out(2) = -omega*(zeta - sqrt(1 - zeta^2)*1i);
end