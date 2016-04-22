close all; clear all;

x = 0; y = 0; theta=0;
xref = 1; yref = 1;
t = 1e-3; tmax = 20;

x_ref = ones(1,tmax/t);
x_ref(round(length(x_ref)/2):end) = 2;

x_store = zeros(1,tmax/t);
y_store = zeros(1,tmax/t);
t_store = zeros(1,tmax/t);

for i = 1:tmax/t

    [v, omega] = Control(x,y,theta,x_ref(i),yref);
    [x,y,theta] = Kinematics(v,omega,x,y,theta,t);
    
    x_store(i) = x;
    y_store(i) = y;
    t_store(i) = theta;
    
end

win = figure; hold on;

time = linspace(0,tmax,tmax/t);

subplot(3,1,1); hold on; 
plot(time,repmat(xref,1,tmax/t));  title('x');
plot(time,x_store); xlabel('time [s]'); ylabel('x [m]');

subplot(3,1,2); hold on; 
plot(time,repmat(yref,1,tmax/t));  title('y');
plot(time,y_store); xlabel('time [s]'); ylabel('y [m]');

subplot(3,1,3); hold on; 
title('y');
plot(time,t_store); xlabel('time [s]'); ylabel({'$\theta$ [m]'}, 'Interpreter','Latex');

%figure; 

%plot(x_store,y_store); xlabel('x [m]'); ylabel('y [m]');
