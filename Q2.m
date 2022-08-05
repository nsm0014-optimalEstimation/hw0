%% Formatting
clc
clear
close all
format shortg
%% Defining state space variables
A = [0 1;0 -1/10];
B = [0;1/10];
C = [1 0];
D = 0;

AB = A*B

[sys_TF_num,sys_TF_den] = ss2tf(A,B,C,D)

syms  s k_1 k_2
K = [k_1 k_2];
BK = B*K

L = [69.9;2493];
LC = L*C

A_comp = A - LC - BK
det([s 0;0 s] - A_comp)
A_esti = A - L*C

syms s K1 K2

K = [K1 K2];
A_c = s*eye(2) - (A-B*K);
det_Ac = det(A_c);

k_pole = pole_calc(omega_nK, zeta);
K_ = place(A, B, k_pole);
% K_ = [39476 878.62];
Bsys_ = ss(A-L_*C-B*K_, L_, -K_, 0);

det([s 0;0 s] - A_esti)

clear
ts = 0;
tf = 5;
tstep = 0.01;
Q2sim = sim('Q3sim.slx');
figure
hold on
step(Bsys_)
% plot(Q2sim.simout.time,Q2sim.simout.signals.values,LineWidth=2)
% plot(Q2sim.simout.time,Q2sim.simout.signals.values,LineWidth=2)
title('Estimator and Controller Response to a Unit Step Input')
xlabel('Time [s]')
ylabel('Response Value')