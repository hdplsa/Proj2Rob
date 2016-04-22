function [ x,y,theta ] = Kinematics( V, w, x, y, theta, t)
    
    %Modelo do uniciclo
    x_dot = cos(theta)*V;
    y_dot = sin(theta)*V;
    th_dot = w;
    %Coordenadas estimadas de posição seguinte seguinte
    x = x + t*x_dot;
    y = y + t*y_dot;
    theta = theta + t*th_dot;
    
end

