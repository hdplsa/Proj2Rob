function [ x_ref, y_ref, j ] = assign_reference( x, y, x_ref, y_ref, caminho )
    % Vamos verificar se a dire��o do vetor da posi��o rob� -> refer�ncia �
    % -180, ou seja, o robo est� � frente da referencia ou se estamos
    % suficientemente pr�ximos do pr�ximo ponto para podermos devolver o
    % pr�ximo
    
    angle = atan((y_ref-y)/(x_ref-x));
    j = 0;
    
    if abs(angle) > pi/2
        
        [x_ref, y_ref, j] = find_next(x,y, caminho);
        
    elseif sqrt((x_ref-x)^2+(y_ref-y)^2) < 10e-2
        
        [x_ref, y_ref, j] = find_next(x,y, caminho);
        
    end
    
end

function [x_ref, y_ref ,j] = find_next( x, y, caminho )
    
    j = 1;
    dist = sqrt((caminho(1,j)-x)^2+(caminho(2,j)-y)^2);
    
    %Se o ponto j� estiver numa posi��o passada, encontra ponto seguinte
    while( atan((y-caminho(2,j))/(x-caminho(1,j))) > pi/2 && dist < 1)
        
        j = j+1;
        dist = sqrt((caminho(1,j)-x)^2+(caminho(2,j)-y)^2);
        
    end
    
    x_ref = caminho(1,j);
    y_ref = caminho(2,j);
    
end


