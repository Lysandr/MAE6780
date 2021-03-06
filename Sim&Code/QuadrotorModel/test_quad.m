%% THIS IS FOR JUST_THE_DYNAMICS1... SORTA WORKS?

% testing the new model i built and linearizing shit
% clear all; clc
% initial_conditions
% LoadQuadrotorConst_XPro1a
% mdl = 'just_the_dynamics';
% blockpath = 'just_the_dynamics/quadmdl';
% linsys = linearize(mdl,blockpath);
% A = linsys.A;
% B = linsys.B;
% C = linsys.C;
% D = linsys.D;
% save('lindyn','A','B','C','D');

%% if you have already linearized
clear all; close all; clc
initial_conditions
LoadQuadrotorConst_XPro1a
load('linsys.mat');
A = LinearAnalysisToolProject.LocalVariables.Value.A;
B = LinearAnalysisToolProject.LocalVariables.Value.B;
C = LinearAnalysisToolProject.LocalVariables.Value.C;
D = LinearAnalysisToolProject.LocalVariables.Value.D;
Q = eye(16); Q(1,1) = 2000; Q(3,3) = 2000; Q(5,5)=2000;
R = 1*eye(4);
stateref = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]';
[K,S,E] = lqr(A,B,Q,R);

tic
sim('just_the_dynamics1');
% sim('quadcopter_model_test')
toc

% plot the trajectory
figure; hold on;
grid on;
plot3(state.Data(:,1), state.Data(:,3), state.Data(:,5)); hold on;
start = plot3(state.Data(1,1), state.Data(1,3), state.Data(1,5)); hold on;
start.Color = 'green';
start.Marker = 'o';
finished = plot3(state.Data(end,1), state.Data(end,3), state.Data(end,5)); hold on;
finished.Color = 'red';
finished.Marker = 'o';
title('Trajectory');
xlabel('X distance (m)')
ylabel('Y distance (m)')
zlabel('Z distance (m)'); hold off;

%STATES
figure; subplot(6,1,1)
plot(state.Time, state.Data(:,1)); title('x vs time')
subplot(6,1,2)
plot(state.Time, state.Data(:,3)); title('y vs time')
subplot(6,1,3)
plot(state.Time, state.Data(:,5)); title('z vs time')
subplot(6,1,4)
plot(state.Time, state.Data(:,7)); title('Phi vs time')
subplot(6,1,5)
plot(state.Time, state.Data(:,9)); title('Theta vs time')
subplot(6,1,6)
plot(state.Time, state.Data(:,11)); title('Psi vs time')

% print off the final value
finalstate = [state.Data(end,1) state.Data(end,3) state.Data(end,5)]

