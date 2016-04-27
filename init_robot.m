function [sp] = init_robot(port)
    
    sp = serial_port_start(port);
    pioneer_init(sp);
    
end
   