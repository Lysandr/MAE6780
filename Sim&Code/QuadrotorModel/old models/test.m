%% testy mctestface
close all
clear all
clc

initial_conditions
LoadQuadrotorConst_XPro1a

A = [0 1 0 0 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 9.8089 0 0 0;
0 0 0 1 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 -9.8089 0 0 0 0 0;
0 0 0 0 0 1 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 1 0 0 0 0;
0 0 0 0 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 1 0 0;
0 0 0 0 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 0 0 1;
0 0 0 0 0 0 0 0 0 0 0 0];


B =[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0;
0.001119 0.001119 0.001119 0.001119;0 0 0 0;
0 0.008234 0 -0.008234;0 0 0 0;-0.008234 0 0.008234 0;
0 0 0 0;-0.005615 0.005615 -0.005615 0.005615];

C = eye(12);
Q = eye(12); Q(1,1) = 1000; Q(3,3) = 1000; Q(5,5) = 1000;
[K,S,E] = lqr(A,B,Q,1*eye(4));
Xref = [2 0 2 0 2 0 0 0 0 0 0 0]';

bb = 6.11e-8;
dd = 1.5e-9;

%%
% T = linspace(0,100,1001)';
% % 0.5*V1_WP.*cos(linspace(0,2*pi*30,1001))'
% V1 = [T zeros(1001,1)];
% V2 = [T zeros(1001,1)];
% V3 = [T zeros(1001,1)];
% V4 = [T zeros(1001,1)];
% Vin = [V1 V2 V3 V4];

tic
sim('CL_Xpro_model');
toc


%% ANGLES AND TRAJECTORY
figure; subplot(3,1,1)
plot(state.Time, state.Data(:,1)); title('x vs time')
subplot(3,1,2)
plot(state.Time, state.Data(:,3)); title('y vs time')
subplot(3,1,3)
plot(state.Time, state.Data(:,5)); title('z vs time')
figure; subplot(3,1,1)
plot(state.Time, state.Data(:,7)); title('Phi vs time')
subplot(3,1,2)
plot(state.Time, state.Data(:,9)); title('Theta vs time')
subplot(3,1,3)
plot(state.Time, state.Data(:,11)); title('Psi vs time')
figure; hold on;
grid on;
plot3(state.Data(:,1), state.Data(:,3), state.Data(:,5));
title('Trajectory');
xlabel('X distance (m)')
ylabel('Y distance (m)')
zlabel('Z distance (m)')


%% ROTOR SPEED PLOT
figure; subplot(4,1,1);title('ROTOR SPEEDS!'); hold on;
plot(rotorspeeds.Time, rotorspeeds.Data(:,1));
subplot(4,1,2)
plot(rotorspeeds.Time, rotorspeeds.Data(:,2));
subplot(4,1,3)
plot(rotorspeeds.Time, rotorspeeds.Data(:,3));
subplot(4,1,4)
plot(rotorspeeds.Time, rotorspeeds.Data(:,4));

%% VOLTAGE PLOT
figure; subplot(4,1,1);title('Voltages!'); hold on;
plot(voltages.Time, voltages.Data(:,1));
subplot(4,1,2)
plot(voltages.Time, voltages.Data(:,2));
subplot(4,1,3)
plot(voltages.Time, voltages.Data(:,3));
subplot(4,1,4)
plot(voltages.Time, voltages.Data(:,4));


%ADDED CONTROLS STUFF
figure; subplot(4,1,1); title('ROTOR COMMANDs'); hold on;
plot(rotorcommands.Time, rotorcommands.Data(:,1));
subplot(4,1,2);
plot(rotorcommands.Time, rotorcommands.Data(:,2));
subplot(4,1,3)
plot(rotorcommands.Time, rotorcommands.Data(:,3)); 
subplot(4,1,4)
plot(rotorcommands.Time, rotorcommands.Data(:,4));



