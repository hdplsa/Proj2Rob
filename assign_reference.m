function [ x_ref, y_ref, j ] = assign_reference( x, y, x_ref, y_ref, caminho )
    % Vamos verificar se a direção do vetor da posição robô -> referência é
    % -180, ou seja, o robo está à frente da referencia ou se estamos
    % suficientemente próximos do próximo ponto para podermos devolver o
    % próximo
    
    angle = atan((y_ref-y)/(x_ref-x));
    j = 0;
    
    if abs(angle) > pi/2
        
        [x_ref, y_ref, j] = find_next(x,y, caminho);
        
    elseif norm((x_ref-x)+(y_ref-y)) < 10e-2
        
        [x_ref, y_ref, j] = find_next(x,y, caminho);
        
    end
    
end

function [x_ref, y_ref ,j] = find_next( x, y, caminho )
    
    j = 1;
    
    %Se o ponto já estiver numa posição passada, encontra ponto seguinte
    while( atan((y-caminho(2,j))/(x-caminho(1,j))) > pi/2)
        
        j = j+1;
        
    end
    
    x_ref = caminho(1,j);
    y_ref = caminho(2,j);
    
end


