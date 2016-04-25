close all; clear;

% Usar um ponteio laser para medir o erro da odometria 

% Posição e orientação auxiliares do robô
x = 0.25; y = -0.75; theta=-pi/4;
t = 1e-2; tmax = 300;

% Cálculo do caminho
caminho = geraCaminho(14.5,0.5);

% Procura a posição do caminho mais próxima do robô
[~,j] = min(sqrt(sum(abs(caminho - repmat([x,y]',1,length(caminho))),1))); j = j(1);
xref = caminho(1,j); yref = caminho(2,j);

% Iniciação de vars auxiliares
x_store = zeros(1,tmax/t);
y_store = zeros(1,tmax/t);
t_store = zeros(1,tmax/t);
v_store = zeros(1,tmax/t);
w_store = zeros(1,tmax/t);
x_ref_store = zeros(1,tmax/t);
y_ref_store = zeros(1,tmax/t);

for i = 1:tmax/t
    
    [xref, yref, aux] = assign_reference(x,y,xref,yref, caminho(:,j:end));
    j = j + aux;
    
    [v, omega] = Control(x,y,theta,xref,yref);
    [x,y,theta] = Kinematics(v,omega,x,y,theta,t);
    
    x_store(i) = x;
    y_store(i) = y;
    t_store(i) = theta;
    v_store(i) = v;
    w_store(i) = omega;
    
    x_ref_store(i) = xref;
    y_ref_store(i) = yref;
    
    h = waitbar(i/(tmax/t));
    
    if size(caminho(:,j:end),2) == 0
        break;
    end
    
end

close(h);

figure; hold on;

time = linspace(0,tmax,tmax/t);

subplot(3,1,1); hold on;
plot(time,x_ref_store);  title('x');
plot(time,x_store); xlabel('time [s]'); ylabel('x [m]');

subplot(3,1,2); hold on;
plot(time,y_ref_store);  title('y');
plot(time,y_store); xlabel('time [s]'); ylabel('y [m]');

subplot(3,1,3); hold on;
plot(time,t_store);  title('theta');
xlabel('time [s]'); ylabel('theta [rad]');

figure; hold on;

subplot(2,1,1);
plot(time,v_store);  title('v');

subplot(2,1,2);
plot(time,w_store);  title('w');

figure; hold on;

plot(x_store,y_store); xlabel('x [m]'); ylabel('y [m]');
plot(caminho(1,:),caminho(2,:));