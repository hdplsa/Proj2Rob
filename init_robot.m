function [sp] = init_robot(port)
    
    if nargin == 0
        port = 'COM4';
    end
    
    sp = robot.serial_port_start(port);
    robot.pioneer_init(sp);
    
end
   