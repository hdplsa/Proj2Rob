function [ odom ] = get_odom()
%   Corrige a odometria, tendo em conta a posi��o e orienta��es iniciais do
%   robot

init = [0 0 0];
%init = [1.80,1.69+1.80 pi/2]; %Para iniciar teste na porta

odom = pioneer_read_odometry();

odom(1:2) = odom(1:2)/1000;
odom(3) = odom(3) * 360/4048*pi/180;

odom = odom + init;
% 
% if odom(3) > pi
%     while odom(3) > pi
%         odom(3) = odom(3) - 2*pi;
%     end
% elseif odom(3) < -pi
%     while odom(3) < pi
%         odom(3) = odom(3) + 2*pi;
%     end
% end

end

