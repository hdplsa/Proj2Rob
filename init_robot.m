function [sp] = init_robot(port)
    
    if nargin == 0
        port = 'COM4';
    end
    
    sp = serial_port_start(port);
    pioneer_init(sp);
    
end
   