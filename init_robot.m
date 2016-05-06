function [sp] = init_robot(port)
%Inicializa ligação e comunicação com o robot    
    if nargin == 0
        port = 'COM4';
    end
    
    sp = serial_port_start(port);
    pioneer_init(sp);
    
end
   