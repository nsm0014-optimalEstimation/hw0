%% Formatting
clc
clear 
close all
format shortg
%% Defining State Space Matrices
A = [0 1;0 -0.1];
B = [0;0.1];
C = [1 0];
D = 0;

L = [439.72; 98652];
K = [39478 878.65];

%% Finding Compensator Transfer Function
syms s

TF_comp = -K*((s*eye(2,2) - A + L*C + B*K)^-1)*L

TF_CL = -C*((s*eye(2,2) - A + L*C + B*K)^-1)*B

TF_comp = tf([-4164279 -24999900],[10 839 35716]);


margin(-500,[5000 2638425 706398849])

