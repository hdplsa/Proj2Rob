function [ var ] = get_odom(x_last,y_last,theta_last)
%   Corrige a odometria, tendo em conta a posição e orientações iniciais do
%   robot
global zona son_esq son_dir i;
% Estas variaveis permanecem inalteradas mesmo após acabar a função
persistent init last_odom;

%largura do robot
lc = 1.67;
lr = 0.270;
ld = 0.456;
corredor = 1.67;

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

% Fazemos a diferença entre a odometria atual e a anterior
delta_odom = odom - last_odom;

% Modulo dessa diferença (espacial)
delta = sqrt(delta_odom(1)^2+delta_odom(2)^2);

% Calcula as novas posições em relação às anteriores e ao que se andou
% num ciclo:
% Y ^
%   | /| odom
%   |/_|___>X
%   old odom
x = x_last + delta*cos(odom(3) + init(3));
y = y_last + delta*sin(odom(3) + init(3));

try
    
    % Lê o valor dos sonares (esquerda -> 1, direita -> end)
    sonars = pioneer_read_sonars(); sonars = sonars/1000;
    
    try
        son_esq(i) = sonars(1);
        son_dir(i) = sonars(end);
    end
    
    %Apenas válido para zonas "normais" (rectas) do corredor
    if (CorrectionDistance(zona,lc,lr,ld,sonars))     
    % Dependendo da zona, corrige a posição através de algoritmos
    % diferentes
        switch zona
            case 2
                xx = x;
                theta = get_orientation(lc,lr,sonars);
                x = -(sonars(end)+lr/2)*cos(theta) + init(1) + corredor/2;
                fprintf('Mudei de %f para %f\n',xx,x);
            case 4
                theta = get_orientation(lc,lr,sonars);
                y = (sonars(1)+lr/2)*cos(theta) + init(2);
            case 6
                theta = get_orientation(lc,lr,sonars);
                x = (sonars(end)+lr/2)*sin(theta) + init(1);
            case 8
                theta = get_orientation(lc,lr,sonars);
                y = (sonars(1)+lr/2)*cos(theta) + init(2);
        end;
    end
    
end

last_odom = odom;

% Retorna os resultados, x e y foram calculados acima, o theta é
% calculado diretamente pela odometria, apenas adicionamos o theta
% inicial
var = [x,y,odom(3) + init(3)];
end

