%% Formatting
clc
clear
close all
format shortg
%% Begin Problem 2 redo
A = [0 1;0 -1/10];
B = [0;1/10];
C = [1 0];
D = 0;

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


% ts = 0;
% tf = 100;
% tstep = 0.0000001;
% Q2sim = sim('P3redosim.slx');
fig1 = figure('Position',[500 500 800 400]);
hold on
step(Bsys_)
% plot(Q2sim.simout.time,Q2sim.simout.signals.values,LineWidth=2)
% plot(Q2sim.simout.time,Q2sim.simout.signals.values,LineWidth=2)
title('Estimator and Controller Response to a Unit Step Input')
% xlim([ts tf])
ylim([-2.5e4 50])
xlabel('Time [s]')
ylabel('Response Value')
saveas(fig1,'Q2redo.png')

function pole_out = pole_calc(omega, zeta)
pole_out(1) = -omega*(zeta + sqrt(1 - zeta^2)*1i);
pole_out(2) = -omega*(zeta - sqrt(1 - zeta^2)*1i);
end