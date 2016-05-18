close all; clear; clear get_odom2; clear teste2;

global t v omega;
% Usar um ponteiro laser para medir o erro da odometria

% Posição e orientação auxiliares do robô
x = 0; y = 0; theta=0; v = 0; omega = 0;
t = 10e-2; tmax = 500;
var = get_odom2(x,y,theta);

% Cálculo do caminho
[px,py] = geraCaminho4(3,3,15.7,1.67);

% Procura a posição do caminho mais próxima do robô
% [~,j] = min(sqrt(sum(abs(caminho - repmat([x,y]',1,length(caminho))),1))); j = j(1); j = j+1;
% xref = caminho(1,j); yref = caminho(2,j);

% Iniciação de vars auxiliares
x_store = zeros(1,tmax/t);
y_store = zeros(1,tmax/t);
t_store = zeros(1,tmax/t);
v_store = zeros(1,tmax/t);
w_store = zeros(1,tmax/t);
x_ref_store = zeros(1,tmax/t);
y_ref_store = zeros(1,tmax/t);
v_ref_store = zeros(1,tmax/t);
w_ref_store = zeros(1,tmax/t);
t_ref_store = zeros(1,tmax/t);
son1 = zeros(1,tmax/t);
son2 = zeros(1,tmax/t);

for i = 2:tmax/t
    
    t_act = i*t; if t_act == 48, break; end;
    
    j = find(py.breaks > t_act); j = j(1) - 1; t_act = t_act - py.breaks(j);
    
    t_vect = [t_act^3 t_act^2 t_act 1]';
    
    x_ref = px.coefs(j,:)*t_vect;
    y_ref = py.coefs(j,:)*t_vect;
    
    theta_ref = atan2(x_ref,y_ref);
    
    vx_ref = [0 3*px.coefs(j,4) 2*px.coefs(j,3) px.coefs(j,2)]*t_vect;
    vy_ref = [0 3*py.coefs(j,4) 2*py.coefs(j,3) py.coefs(j,2)]*t_vect;
    
    v_ref = sqrt(vx_ref^2 + vy_ref^2);
    omega_ref = atan2(vx_ref,vy_ref);
    
    k1 = 1;
    k2 = 0.1;
    k3 = 0.1;
    
    if theta > pi
        while theta > pi
            theta = theta - 2*pi;
        end
    elseif theta < -pi
        while theta < -pi
            theta = theta + 2*pi;
        end
    end
    
    v = cos(theta_ref-theta)*v_ref + k1*(x_ref-x);
    omega = omega_ref - k2*v_ref*sinc(theta_ref-theta)*(y_ref-y) + k3*(theta_ref - theta);
    
    
    [x,y,theta] = Kinematics(v,omega,x,y,theta,t);
    %     var = get_odom2(x,y,theta);
    %     x = var(1); y = var(2); theta = var(3);
    
    x_store(i) = x;
    y_store(i) = y;
    t_store(i) = theta;
    v_store(i) = v;
    w_store(i) = omega;
    %e_store(i) = e;
    
    x_ref_store(i) = x_ref;
    y_ref_store(i) = y_ref;
    v_ref_store(i) = v_ref;
    w_ref_store(i) = omega_ref;
    t_ref_store(i) = theta_ref;
    
    h = waitbar(i/(tmax/t));
    
    %     if size(caminho(:,j:end),2) == 0
    %         break;
    %     end
    
end

close(h);
% integrateErro(e_store,10e-2);

% Apaga posições do vetor superfluas (caso não cheguemos ao valor final de
% tempo de simulação, ou seja, o robô é mais rápido do que o tempo de
% simulação)

x_store(i:end) = [];
y_store(i:end) = [];
t_store(i:end) = [];
v_store(i:end) = [];
w_store(i:end) = [];

x_ref_store(i:end) = [];
y_ref_store(i:end) = [];
v_ref_store(i:end) = [];
w_ref_store(i:end) = [];
t_ref_store(i:end) = [];

% Plots
% Figura 1 - plots espaço/angulo tempo (x,t), (y,t) e (theta,t)

figure; hold on;

time = linspace(0,i*t,i-1);

subplot(3,1,1); hold on;
plot(time,x_ref_store);  title('x');
plot(time,x_store); xlabel('time [s]'); ylabel('x [m]');

subplot(3,1,2); hold on;
plot(time,y_ref_store);  title('y');
plot(time,y_store); xlabel('time [s]'); ylabel('y [m]');

subplot(3,1,3); hold on;
plot(time,t_ref_store); plot(time,t_store);  title('theta');
xlabel('time [s]'); ylabel('theta [rad]');

% Figura 2 - Velocidades conforme o tempo (v,t) e (omega,t)

figure; hold on;

subplot(2,1,1); hold on;
plot(time,v_store);  title('v');
plot(time,v_ref_store);

subplot(2,1,2); hold on;
plot(time,w_store);  title('w');
plot(time,w_ref_store);

% Figura 3 - Plot (x,y) que exprime a trajetoria do robô no mapa

figure; hold on;

plot(x_store,y_store); xlabel('x [m]'); ylabel('y [m]');
plot(x_ref_store,y_ref_store);