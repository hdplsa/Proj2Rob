close all; clear;

% Usar um ponteio laser para medir o erro da odometria 

x = 0.25; y = -0.5; theta=-pi/2;
xref = 0; yref = 0;
t = 1e-2; tmax = 100;

x_store = zeros(1,tmax/t);
y_store = zeros(1,tmax/t);
x_ref_store = zeros(1,tmax/t);
y_ref_store = zeros(1,tmax/t);
caminho = geraCaminho(14.5,0.5);
j = 1;

for i = 1:tmax/t
    
    [xref, yref, aux] = assign_reference(x,y,xref,yref, caminho(:,j:end));
    j = j + aux;
    
    [v, omega] = Control(x,y,theta,xref,yref);
    [x,y,theta] = Kinematics(v,omega,x,y,theta,t);
    
    x_store(i) = x;
    y_store(i) = y;
    t_store(i) = theta;
    
    x_ref_store(i) = xref;
    y_ref_store(i) = yref;
    
    h = waitbar(i/(tmax/t));
end

close(h);

win = figure; hold on;

time = linspace(0,tmax,tmax/t);

subplot(3,1,1); hold on;
plot(time,x_ref_store);  title('x');
plot(time,x_store); xlabel('time [s]'); ylabel('x [m]');

subplot(3,1,2); hold on;
plot(time,y_ref_store);  title('y');
plot(time,y_store); xlabel('time [s]'); ylabel('y [m]');

subplot(3,1,3); hold on;
plot(time,t_store);  title('theta');
xlabel('time [s]'); ylabel('theta [m]');

figure;

plot(x_store,y_store); xlabel('x [m]'); ylabel('y [m]');