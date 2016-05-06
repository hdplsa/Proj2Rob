function [sp] = init_robot(port)
%Inicializa liga��o e comunica��o com o robot    
    if nargin == 0
        port = 'COM4';
    end
    
    sp = serial_port_start(port);
    pioneer_init(sp);
    
end
   