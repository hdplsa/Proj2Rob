function [ var ] = get_odom(x_last,y_last,theta_last)
    %   Corrige a odometria, tendo em conta a posição e orientações iniciais do
    %   robot
    
    % Estas variaveis permanecem inalteradas mesmo após acabar a função
    persistent init last_odom zona;
    
    %largura do robot
    lr = 0.381;
    
    if isempty(init)
        init = [1.865 3.6 pi/2];
    end
    
    if isempty(last_odom)
        last_odom = init;
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
        if sonars(1) >= 3500 || sonars(end) >= 3500
            error('');
        end
        
        
        %Apenas válido para zonas "normais" do corredor
        if ((sonars(1)+sonars(end)+lr) <= 2360)
            % Dependendo da zona, calculamos o theta de forma diferente
            switch zona
                case 2
                    theta = asin(1.67/(sonars(1)+ 0.381 +sonars(end)));
                    x = (sonars(end)+0.381/2)*sin(theta) + init(1);
                case 4
                    theta = asin(1.67/(sonars(1)+ 0.381 +sonars(end)));
                    y = (sonars(1)+0.381/2)*cos(theta) + init(2);
                case 6
                    theta = asin(1.67/(sonars(1)+ 0.381 +sonars(end)));
                    x = (sonars(end)+0.381/2)*sin(theta) + init(1);
                case 8
                    theta = asin(1.67/(sonars(1)+ 0.381 +sonars(end)));
                    y = (sonars(1)+0.381/2)*cos(theta) + init(2);
            end;
        end
            
    end
    
    last_odom = odom;
    
    % Retorna os resultados, x e y foram calculados acima, o theta é
    % calculado diretamente pela odometria, apenas adicionamos o theta
    % inicial
    var = [x,y,odom(3) + init(3)];
end

