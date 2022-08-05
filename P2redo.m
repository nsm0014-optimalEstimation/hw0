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

L = place(A',C',roots([1,(2*2*pi*omega_n*zeta),(2*pi*omega_n)^2]))

ts = 0;
tf = 9/(zeta*50*2*pi);
tstep = 0.0000001;
Q2sim = sim('P2redosim.slx');
fig1 = figure('Position',[500 500 800 400]);
hold on
% plot(Q2sim.simout.time,Q2sim.simout.signals.values,LineWidth=2)
plot(Q2sim.simout.time,Q2sim.simout.signals.values,LineWidth=2)
title('Estimator and Controller Response to a Unit Step Input')
xlim([ts tf])
ylim([0 1.1*max(Q2sim.simout.signals.values)])
xlabel('Time [s]')
ylabel('Response Value')
saveas(fig1,'Q2redo.png')