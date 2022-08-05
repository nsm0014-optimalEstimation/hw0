%% Formatting
clc
clear
close all
format shortg
%% Question 3
A  = [0 1;0 -0.1];
B = [0;0.1];
C = [1 0];
D = 0;

L = [69.9;2493];
K = [1000 139];


A_comp = A - B*K - L*C

ts = 0;
tf = 1000;
tstep = 0.001;

sim = sim("Q3sim.slx")

figure
hold on
plot(sim.simout.time,sim.simout.signals.values,LineWidth=2)
plot(sim.simout.time,sim.simout.signals.values,LineWidth=2)
title('Estimator and Controller Response to a Unit Step Input')
xlabel('Time [s]')
ylabel('Response Value')