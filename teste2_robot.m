close all; clear;

% Inicia a serial port e o rob�
sp = init_robot();

% Posi��o e orienta��o auxiliares do rob�
odom = robot.pioneer_read_odometry();
x = odom(1); y = odom(2); theta = odom(3);
t = 10e-2; tmax = 500;

% C�lculo do caminho
caminho = geraCaminho3(3,3,14.5,0.5)';
caminho = flipud(caminho')'; caminho = [caminho, [0;0]];

% Procura a posi��o do caminho mais pr�xima do rob�
[~,j] = min(sqrt(sum(abs(caminho - repmat([x,y]',1,length(caminho))),1))); j = j(1);
xref = caminho(1,j); yref = caminho(2,j);

% Inicia��o de vars auxiliares
x_store = zeros(1,tmax/t);
y_store = zeros(1,tmax/t);
t_store = zeros(1,tmax/t);
v_store = zeros(1,tmax/t);
w_store = zeros(1,tmax/t);
x_ref_store = zeros(1,tmax/t);
y_ref_store = zeros(1,tmax/t);
e_store = zeros(1,tmax/t);

for i = 2:tmax/t
    
    [xref, yref, aux] = assign_reference(x,y,xref,yref, caminho(:,j:end));
    j = j + aux;
    
    [v, omega,e] = Control(x,y,theta,xref,yref,v_store(i-1),w_store(i-1));
    %[x,y,theta] = Kinematics(v,omega,x,y,theta,t);
    odom = robot.pioneer_read_odometry();
    x = odom(1); y = odom(2); theta = odom(3);
    
    robot.pioneer_set_controls(sp,round(v*1000),round(omega*1000));
    
    x_store(i) = x;
    y_store(i) = y;
    t_store(i) = theta;
    v_store(i) = round(v*1000);
    w_store(i) = round(omega*1000);;
    e_store(i) = e;
    
    x_ref_store(i) = xref;
    y_ref_store(i) = yref;
    
    h = waitbar(i/(tmax/t));
    
    if size(caminho(:,j:end),2) == 0
        break;
    end
    
end

close(h);

% Apaga posi��es do vetor superfluas (caso n�o cheguemos ao valor final de
% tempo de simula��o, ou seja, o rob� � mais r�pido do que o tempo de
% simula��o)

x_store(i:end) = [];
y_store(i:end) = [];
t_store(i:end) = [];
v_store(i:end) = [];
w_store(i:end) = [];
e_store(i:end) = [];

x_ref_store(i:end) = [];
y_ref_store(i:end) = [];

% Plots
% Figura 1 - plots espa�o/angulo tempo (x,t), (y,t) e (theta,t)

figure; hold on;

time = linspace(0,i*t,i-1);

subplot(3,1,1); hold on;
plot(time,x_ref_store);  title('x');
plot(time,x_store); xlabel('time [s]'); ylabel('x [m]');

subplot(3,1,2); hold on;
plot(time,y_ref_store);  title('y');
plot(time,y_store); xlabel('time [s]'); ylabel('y [m]');

subplot(3,1,3); hold on;
plot(time,t_store);  title('theta');
xlabel('time [s]'); ylabel('theta [rad]');

% Figura 2 - Velocidades conforme o tempo (v,t) e (omega,t)

figure; hold on;

subplot(2,1,1);
plot(time,v_store);  title('v');

subplot(2,1,2);
plot(time,w_store);  title('w');

% Figura 3 - Plot (x,y) que exprime a trajetoria do rob� no mapa

figure; hold on;

plot(x_store,y_store); xlabel('x [m]'); ylabel('y [m]');
plot(caminho(1,:),caminho(2,:));