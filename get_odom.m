function [ odom ] = get_odom()
%UNTITLED Summary of this function goes here
%   Corrige a odometria, tendo em conta a posição e orientações iniciais do
%   robo

init = [0 0 0];

odom = pioneer_read_odometry();

odom(1:2) = odom(1:2)/1000;
odom(3) = odom(3) * 360/4048*pi/180;

odom = odom + init;

if odom(3) > pi
    while odom(3) > pi
        odom(3) = odom(3) - 2*pi;
    end
elseif odom(3) < -pi
    while odom(3) < pi
        odom(3) = odom(3) + 2*pi;
    end
end

end

