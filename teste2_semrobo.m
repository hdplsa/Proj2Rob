close all; clear;

% Identifica as vars que guardam dados como globais

global x_store y_store t_store v_store w_store x_ref_store y_ref_store e_store x y theta t h1 h2 h3;

% Inicia a serial port e o robô
sp = 1;

% Posição e orientação auxiliares do robô
%odom = robot.pioneer_read_odometry();
x = 0; y = 0; theta = pi/2;
t = 10e-2; tmax = 500;

% Cálculo do caminho
caminho = geraCaminho3(3,3,14.5,0.5)';
caminho = flipud(caminho')'; caminho = [caminho, [0;0]];

% Procura a posição do caminho mais próxima do robô
[~,j] = min(sqrt(sum(abs(caminho - repmat([x,y]',1,length(caminho))),1))); j = j(1);
xref = caminho(1,j); yref = caminho(2,j);

% Iniciação do objeto timer que irá correr o envio da informação

tim = timer('Period', t/10, 'ExecutionMode', 'fixedSpacing');
tim.TimerFcn = {@sendData_semrobo,sp,caminho(:,j:end)};

% Iniciação de vars auxiliares
x_store = zeros(1,tmax/t);
y_store = zeros(1,tmax/t);
t_store = zeros(1,tmax/t);
v_store = zeros(1,tmax/t);
w_store = zeros(1,tmax/t);
x_ref_store = zeros(1,tmax/t);
y_ref_store = zeros(1,tmax/t);
e_store = zeros(1,tmax/t);

x_ref_store(1) = xref; y_ref_store(1) = yref; 

start(tim);

% Plots
% Figura 1 - plots espaço/angulo tempo (x,t), (y,t) e (theta,t)

h1 = figure; hold on;

time = linspace(0,tmax,tmax/t);

subplot(3,1,1); hold on;
plot(time,x_ref_store); linkdata on; title('x');
plot(time,x_store); xlabel('time [s]'); ylabel('x [m]');

subplot(3,1,2); hold on;
plot(time,y_ref_store); linkdata on; title('y');
plot(time,y_store); xlabel('time [s]'); ylabel('y [m]');

subplot(3,1,3); hold on;
plot(time,t_store); linkdata on; title('theta');
xlabel('time [s]'); ylabel('theta [rad]');


% Figura 2 - Velocidades conforme o tempo (v,t) e (omega,t)

figure; hold on;

subplot(2,1,1);
h2 = plot(time,v_store);  title('v');

subplot(2,1,2);
plot(time,w_store);  title('w');

% Figura 3 - Plot (x,y) que exprime a trajetoria do robô no mapa

figure; hold on;

h3 = plot(x_store,y_store); xlabel('x [m]'); ylabel('y [m]');
plot(caminho(1,:),caminho(2,:));