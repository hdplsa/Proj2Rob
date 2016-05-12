close all; clear all; clear persistent; clear global;  delete(timerfindall)

% Identifica as vars que guardam dados como globais

global v v_act omega omega_act zona son_dir son_esq i;

% Inicia a serial port e o rob�
sp = init_robot('COM4');

% Posi��o e orienta��o auxiliares do rob�
%odom = get_odom(0,0,0);
odom = get_odom(1.865,3.6,pi/2);
x = odom(1); y = odom(2); theta = odom(3);
t = 0.5; tmax = 10000; tempo = 0.1;

% C�lculo do caminho
caminho = geraCaminho3(2.7,3.6+1.67,15.7,1.67)';
caminho = flipud(caminho')'; caminho = [caminho, [0;0]];

% Procura a posi��o do caminho mais pr�xima do rob�
[~,j] = min(sqrt(sum(abs(caminho - repmat([x,y]',1,length(caminho))),1))); j = j(1);
xref = caminho(1,j); yref = caminho(2,j);

j = j +1;
% Inicia��o do objeto timer que ir� correr o envio da informa��o

tim = timer('Period', t, 'ExecutionMode', 'fixedSpacing');
tim.TimerFcn = {@send_data_robot,sp};

% Inicia��o de vars auxiliares
x_store = zeros(1,tmax/t);
y_store = zeros(1,tmax/t);
t_store = zeros(1,tmax/t);
v_store = zeros(1,tmax/t);
w_store = zeros(1,tmax/t);
x_ref_store = zeros(1,tmax/t);
y_ref_store = zeros(1,tmax/t);
e_store = zeros(1,tmax/t);
time_store = zeros(1,tmax/t);
son_esq = zeros(1,tmax/t);
son_dir = zeros(1,tmax/t);

x_ref_store(1) = xref; y_ref_store(1) = yref;
v_act = 0; omega_act = 0; v = 0; omega = 0;

% Plots
% Figura 1 - plots espa�o/angulo tempo (x,t), (y,t) e (theta,t)

figure; hold on;

subplot(3,1,1); hold on;
h1 = plot(time_store,x_ref_store); title('x');
h2 = plot(time_store,x_store); xlabel('time [s]'); ylabel('x [m]');

subplot(3,1,2); hold on;
h3 = plot(time_store,y_ref_store); title('y');
h4 = plot(time_store,y_store); xlabel('time [s]'); ylabel('y [m]');

subplot(3,1,3); hold on;
h5 = plot(time_store,t_store); title('theta');
xlabel('time [s]'); ylabel('theta [rad]');

% Figura 2 - Velocidades conforme o tempo (v,t) e (omega,t)

figure; hold on;

subplot(2,1,1);
h6 = plot(time_store,v_store);  title('v');

subplot(2,1,2);
h7 = plot(time_store,w_store);  title('w');

% Figura 3 - Plot (x,y) que exprime a trajetoria do rob� no mapa

figure; hold on;

h8 = plot(x_store,y_store);
xlabel('x [m]'); ylabel('y [m]');
plot(caminho(1,:),caminho(2,:));

h = {h1 h2 h3 h4 h5 h6 h7 h8};

% Come�a o timer que envia os dados para o robo

start(tim);

button = 1;
i = 2;
while button
    
    odom = get_odom(x,y,theta);
    x = odom(1); y = odom(2); theta = odom(3);
    
    sonars = pioneer_read_sonars();

    [xref, yref, aux] = assign_reference(x,y,xref,yref, caminho(:,j:end));
    j = j + aux;
    
%     switch j
%         case {1,2}
%             zona = 1;
%         case 3
%             zona = 2;
%         case 4
%             zona = 3;
%         case 5
%             zona = 4;
%         case 6
%             zona = 5;
%         case 7
%             zona = 6;
%         case 8
%             zona = 7;
%         case 9
%             zona = 8;
%         case 10
%             zona = 9;
%         case 11
%             zona = 10;
%     end
    zona = 2;
    [v, omega,e] = Control(x,y,theta,xref,yref,v_store(i-1),w_store(i-1),sonars);
    
    x_store(i) = x;
    y_store(i) = y;
    t_store(i) = theta;
    v_store(i) = v_act;
    w_store(i) = omega_act;
    e_store(i) = e;
    time_store(i) = i*t;
    
    x_ref_store(i) = xref;
    y_ref_store(i) = yref;
    
    if size(caminho(:,j:end),2) == 0
        stop(tim);
        break;
    end
    
    i = i+1;
    
    pause(tempo);
    
    if mod(i,10) == 0
        fprintf('Ciclo %d\n',i);
        update_plots( h, x_store, x_ref_store, y_store, y_ref_store, t_store, v_store, w_store, time_store );
    end
end

