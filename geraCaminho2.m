function [path] = geraCaminho2(l,d)
    %Função que gera todos os pontos do caminho que o robot tem que percorrer
    %   l: lado do quadrado central da torre
    %   d: largura do corredor da torre
    
%     pontos = [0,0;
%               0,-l/2;
%               0,-l;
%               d,-l;
%               d,0;
%               0,0];

    pontos = [0, 0; 0, -l/2; 0 -l];
        
    [ax, t] = gera_reta(0, l, 0, 0, 0.35); return;
    
    x = pontos(:,1); y = pontos(:,2);
          
    vmax = 0.35;
    
    t(1) = 0;
    
    t(2) = t(1) + sqrt((pontos(1,1)-pontos(1+1,1))^2+(pontos(1,2)-pontos(1+1,2))^2)/vmax;
    
    tf = t(1+1) - t(1);
    
    ax(1,:) = [ x(1) 0 3/tf^2*(x(1)-x(2))-2/tf*0-1/tf*vmax -2/tf^3*(x(1)-x(2))+1/tf^2*(vmax-0)];
    
    for i = 2:size(pontos,1)-1
       
        t(i+1) = t(i) + sqrt((pontos(i,1)-pontos(i+1,1))^2+(pontos(i,2)-pontos(i+1,2))^2)/vmax;
        
        tf = t(i+1) - t(i);
        
        ax(i,:) = [ x(i), vmax, 3/tf^2*(x(i)-x(i+1))-2/tf*vmax-1/tf*vmax, -2/tf^3*(x(i)-x(i+1))+2/tf^2*(vmax-vmax)];
        
    end
          
    
    
end

function [ax, t] = gera_reta(x_ini, x_fin, t_ini, v_ini, vmax)
    
    delta_x = 1;
    
    x = linspace(x_ini,x_fin,ceil((x_fin-x_ini)/delta_x));
    
    v = vmax*ones(size(x)); v(1) = 0; v(end) = 0;
    
    t = t_ini + [0 , delta_x*2/vmax, ... 
        delta_x*2/vmax + delta_x/vmax*(1:(length(x)-3)), ... 
        delta_x*2/vmax + delta_x/vmax*(length(x)-3) + delta_x*2/vmax];
    
    i = 1; tf = t(i+1) - t(i);
    
        ax(i,:) = [x(i); ...
                   v(i); ...
                   3/tf^2*(x(i+1)-x(i)) - 2/tf*v(i) - 1/tf*v(i+1); ...
                   -2/tf^3*(x(i+1)-x(i)) + 1/tf^2*(v(i+1)+v(i))]; 
           
    for i = 2:length(x)-1
       
        tf = t(i+1);
        
        x(i) = ax(i-1,:)*[1 t(i) t(i)^2 t(i)^3]';
        v(i) = ax(i-1,2:end)*[1 2*t(i) 3*t(i)^2]';
        
        ax(i,:) = [x(i); ...
                   v(i); ...
                   3/tf^2*(x(i+1)-x(i)) - 2/tf*v(i) - 1/tf*v(i+1); ...
                   -2/tf^3*(x(i+1)-x(i)) + 1/tf^2*(v(i+1)+v(i))]; 
        
        
    end
    
    plottraj(ax, t)
    
end

function plottraj(ax, time)
    
    figure; hold on;
    
   for i = 1:size(ax,1)
      
       t = linspace(time(i),time(i+1),1000);
       y = ax(i,1)*ones(size(t)) + ax(i,2)*t + ax(i,3)*t.^2 + ax(i,4)*t.^3; 
       
       plot(t,y);
       
   end
    
    
    
end

