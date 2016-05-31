close all; clear; delete(timerfindall)

% Identifica as vars que guardam dados como globais

global v v_act omega omega_act new_msg message;

% Inicia a serial port e o robô
sp = 1;

% Posição e orientação auxiliares do robô
%odom = robot.pioneer_read_odometry();
x = 0; y = 0; theta = 0;
t = 0.5; tmax = 10000; tempo = 0.1;

% Cálculo do caminho
caminho = geraCaminho3(0.3*4+1.67/2,0.3*12+1.67,15.7,1.67)';
caminho = flipud(caminho')'; caminho = [caminho, [0;0]];

% Procura a posição do caminho mais próxima do robô
[~,j] = min(sqrt(sum(abs(caminho - repmat([x,y]',1,length(caminho))),1))); j = j(1);
xref = caminho(1,j); yref = caminho(2,j);

% Iniciação do objeto timer que irá correr o envio da informação

tim = timer('Period', t/10, 'ExecutionMode', 'fixedSpacing');
tim.TimerFcn = {@send_data,sp};

tim_qr = timer('Period', 0.1, 'ExecutionMode', 'fixedSpacing');
tim_qr.TimerFcn = {@get_qr};

% Iniciação de vars auxiliares
x_store = zeros(1,tmax/t);
y_store = zeros(1,tmax/t);
t_store = zeros(1,tmax/t);
v_store = zeros(1,tmax/t);
w_store = zeros(1,tmax/t);
x_ref_store = zeros(1,tmax/t);
y_ref_store = zeros(1,tmax/t);
e_store = zeros(1,tmax/t);
time_store = zeros(1,tmax/t);

x_ref_store(1) = xref; y_ref_store(1) = yref;
v_act = 0; omega_act = 0; v = 0; omega = 0;

% Plots
% Figura 1 - plots espaço/angulo tempo (x,t), (y,t) e (theta,t)

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

% Figura 3 - Plot (x,y) que exprime a trajetoria do robô no mapa

figure; hold on;

h8 = plot(x_store,y_store);
xlabel('x [m]'); ylabel('y [m]');
plot(caminho(1,:),caminho(2,:));

h = {h1 h2 h3 h4 h5 h6 h7 h8};

% Começa o timer que envia os dados para o robo

start(tim);
start(tim_qr);

button = 1;
i = 2;
while button
    
    [xref, yref, aux] = assign_reference(x,y,xref,yref, caminho(:,j:end));
    j = j + aux;
    
    zona = get_zona(j);
    
    % Detetou um QR Code
    if new_msg
        if zona == 2 || zona == 4 || zona == 6 || zona == 8 || zona == 10
            switch message
                case '1'
                    fprintf('zona: %d', zona);
                    fprintf('message: %s', message);
                    if zona == 2
                        zona = 3;
                        y = 20.97;
                        disp('mudei para a zona 3');
                    end
                case '2'
                    if zona == 4
                        zona = 5;
                        x = 17.73;
                    end
                case '3'
                    if zona == 6
                        zona = 7;
                        y = 5.27;
                    end
                case '4'
                    if zona == 8
                        zona = 9;
                        x = 2.035;
                    end
                otherwise
                    disp(message);
            end
        end
        new_msg = 0; message = [];
    end
    
    [v, omega,e] = Control(x,y,theta,xref,yref,v_store(i-1),w_store(i-1),5000*ones([1,12]),zona);
    [x,y,theta] = Kinematics(v_act,omega_act,x,y,theta,tempo);
    
    %     x = x + 0.0005;
    
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
    pause(tempo/10);
    if mod(i,50) == 0
        fprintf('Ciclo %d\n',i);
        tic
        update_plots(h, x_store, x_ref_store, y_store, y_ref_store, t_store, v_store, w_store, time_store);
        toc
    end
end