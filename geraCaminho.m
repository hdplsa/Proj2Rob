function [path] = geraCaminho(l,d,DEBUG)
    %Função que gera todos os pontos do caminho que o robot tem que percorrer
    %   l: lado do quadrado central da torre
    %   d: largura do corredor da torre
    
    if nargin <  3
        DEBUG = 0;
    end
    
    close all;
    r = d/2;
    path = [];
    step = l;
    step_curva = 0.5;
    
    %1ª linha vertical
    p = -1*(0:step:l);
    pathaux = [];
    for i=1:length(p)
        pathaux(1,i) = r;
        pathaux(2,i) = p(i);
    end
    path = pathaux;
    
    %Canto inferior esquerdo
    p = -1*(l:step_curva:l+r);
    pathaux = [];
    for i=1:length(p)
        pathaux(1,i) = 2*r-sqrt(r^2-(p(i)-(-l))^2);
        pathaux(2,i) = p(i);
    end
    path = [path pathaux];
    
    %1ª linha horizontal
    p = (2*r:step:2*r+l);
    pathaux = [];
    for i=1:length(p)
        pathaux(1,i) = p(i);
        pathaux(2,i) = -l-r;
    end
    path = [path pathaux];
    
    %Canto inferior direito
    p = -1*(l:step_curva:l+r);
    p = flip(p);
    pathaux = [];
    for i=1:length(p)
        pathaux(1,i) = (2*r+l)+sqrt(r^2-(p(i)-(-l))^2);
        pathaux(2,i) = p(i);
    end
    path = [path pathaux];
    
    %2ª linha vertical
    p = 1*(-l:step:0);
    pathaux = [];
    for i=1:length(p)
        pathaux(1,i) = 3*r+l;
        pathaux(2,i) = p(i);
    end
    %pathaux
    path = [path pathaux];
    
    %Canto superior direito
    p = (0:step_curva:r);
    pathaux = [];
    for i=1:length(p)
        pathaux(1,i) = (2*r+l)+sqrt(r^2-(p(i))^2);
        pathaux(2,i) = p(i);
    end
    path = [path pathaux];
    
    %2ª linha horizontal
    p = (2*r:step:2*r+l);
    p = flip(p);
    pathaux = [];
    for i=1:length(p)
        pathaux(1,i) = p(i);
        pathaux(2,i) = r;
    end
    path = [path pathaux];
    
    %Canto superior esquerdo
    p = (0:step_curva:r);
    p = flip(p);
    pathaux = [];
    for i=1:length(p)
        pathaux(1,i) = (2*r)-sqrt(r^2-(p(i))^2);
        pathaux(2,i) = p(i);
    end
    path = [path pathaux];
    
    %Gráfico do caminho
    if DEBUG
        plot(path(1,:),path(2,:));
        title('Caminho a ser percorrido pelo Robot');
        xlabel('x');
        ylabel('y');
    end
end

