function [ var ] = get_odom(x_last,y_last,theta_last)
%   Corrige a odometria, tendo em conta a posi��o e orienta��es iniciais do
%   robot
global zona son_esq son_dir i;
% Estas variaveis permanecem inalteradas mesmo ap�s acabar a fun��o
persistent init last_odom;

%Medidas do percurso
lc = 1.695; %largura do corredor
lr = 0.268; %largura do robot
ld = 0.455; %largura das pernas dos bancos

if isempty(init)
    init = [x_last y_last theta_last];
end

if isempty(last_odom)
    last_odom = [0 0 0];
    var = [x_last, y_last, theta_last];
    return;
end

% Vai buscar a odometria
odom = pioneer_read_odometry();

% Muda a odometria para metros e radianos
odom(1:2) = odom(1:2)/1000;
odom(3) = odom(3)*(360/4048)*(pi/180);

% Fazemos a diferen�a entre a odometria atual e a anterior
delta_odom = odom - last_odom;

% Modulo dessa diferen�a (espacial)
delta = sqrt(delta_odom(1)^2+delta_odom(2)^2);

% Calcula as novas posi��es em rela��o �s anteriores e ao que se andou
% num ciclo:
% Y ^
%   | /| odom
%   |/_|___>X
%   old odom
x = x_last + delta*cos(odom(3) + init(3));
y = y_last + delta*sin(odom(3) + init(3));

try
    
    % L� o valor dos sonares (esquerda -> 1, direita -> end)
    sonars = pioneer_read_sonars(); sonars = sonars/1000; sonars = sonars(1:8);
    
    try
        son_esq(i) = sonars(1);
        son_dir(i) = sonars(end);
    end
    
    %Apenas v�lido para zonas "normais" (rectas) do corredor
    if (CorrectionDistance(zona,lc,lr,ld,sonars))     
    % Dependendo da zona, corrige a posi��o atrav�s de algoritmos
    % diferentes
        switch zona
            case 2
                xx = x;
                theta = get_orientation(lc,lr,sonars);
                x = -(sonars(end)+lr/2)*cos(theta) + 1.2000 + 1.69/2;
                fprintf('Mudei de %f para %f\n',xx,x);
            case 4
                yy = y;
                theta = get_orientation(lc,lr,sonars);
                y = 19.6500 - (sonars(1)+lr/2)*cos(theta);
                 fprintf('Mudei de %f para %f\n',yy,y);
            case 6
                theta = get_orientation(lc,lr,sonars);
                x = 15.6825 + (sonars(1)+lr/2)*cos(theta);
            case 8
                theta = get_orientation(lc,lr,sonars);
                y = 3.6 + (sonars(1)+lr/2)*cos(theta);
        end;
    end
catch e
   %disp(e);
end

last_odom = odom;

% Retorna os resultados, x e y foram calculados acima, o theta �
% calculado diretamente pela odometria, apenas adicionamos o theta
% inicial
var = [x,y,odom(3) + init(3)];
end

