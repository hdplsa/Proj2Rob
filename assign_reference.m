function [ x_ref, y_ref, j ] = assign_reference( x, y, x_ref, y_ref, caminho )
    
    global zona;
    
    % Vamos verificar se a direção do vetor da posição robô -> referência é
    % -180, ou seja, o robo está à frente da referencia ou se estamos
    % suficientemente próximos do próximo ponto para podermos devolver o
    % próximo
    
    angle = atan((y_ref-y)/(x_ref-x));
    j = 0;
    
    if abs(angle) > pi/2
        
        %[x_ref, y_ref, j] = find_next(x,y, caminho);
        
    elseif sqrt((x_ref-x)^2+(y_ref-y)^2) < 10e-2
        
        % Mensagens de debug porque o as funções com timer não param nos
        % breakpoints
        
        disp(j);
        
        fprintf('Mudada a ref, o erro era %f\n',sqrt((x_ref-x)^2+(y_ref-y)^2));
        fprintf('x: %f, y: %f, x_ref: %f, y_ref: %f\n',x,y,x_ref,y_ref);
        
        [x_ref, y_ref, j] = find_next(x,y, caminho);
        
        fprintf('Nova ref, x_ref: %f; y_ref: %f\n',x_ref,y_ref);
        
    end
    
    if zona == 2
        if sqrt((y_ref-y)^2) < 10e-2
            [x_ref, y_ref, j] = find_next(x,y, caminho);
            
            fprintf('Nova ref, x_ref: %f; y_ref: %f\n',x_ref,y_ref);
        end
    end
    
end

function [x_ref, y_ref ,j] = find_next( x, y, caminho )
    
    j = 1;
    dist = sqrt((caminho(1,j)-x)^2+(caminho(2,j)-y)^2);
    
    % Se o ponto já estiver numa posição passada, encontra ponto seguinte
    while( atan((y-caminho(2,j))/(x-caminho(1,j))) > pi/2 && dist < 0.3)
        
        j = j+1;
        dist = sqrt((caminho(1,j)-x)^2+(caminho(2,j)-y)^2);
        
    end
    
    x_ref = caminho(1,j);
    y_ref = caminho(2,j);
    
end


