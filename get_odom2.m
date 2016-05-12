function [ var ] = get_odom2(x_last,y_last,theta_last)
%   Corrige a odometria, tendo em conta a posição e orientações iniciais do
%   robot

global t v omega;
persistent init last_odom zona;

if isempty(init)
    init = [1.80 1.69+1.80 pi/2];
end

if isempty(last_odom)
    last_odom = init;
end

[x,y,theta] = Kinematics(v,omega,x_last,y_last,theta_last,t);
odom = [x y theta];

%odom = pioneer_read_odometry();

% Tirei a mudança para metros por causa de ser simulado
odom(1:2) = odom(1:2);
odom(3) = odom(3) - init(3);

delta_odom = odom - last_odom;

delta = sqrt(delta_odom(1)^2+delta_odom(2)^2);

x = x_last + delta*cos(odom(3) + init(3));
y = y_last + delta*sin(odom(3) + init(3));

try
%     sonars = pioneer_read_sonars(); sonars = sonars/1000;
%     if sonars(1) >= 3500 || sonars(end) >= 3500
%         error('');
%     end
%     
%     switch zona
%             case 2
%             theta = asin(1.67/(sonars(1)+ 0.381 +sonars(end)));
%             x = (sonars(end)+0.381/2)*sin(theta) + init(1);
%         case 4
%             theta = asin(1.67/(sonars(1)+ 0.381 +sonars(end)));
%             y = (sonars(1)+0.381/2)*cos(theta) + init(2);
%         case 6
%             theta = asin(1.67/(sonars(1)+ 0.381 +sonars(end)));
%             x = (sonars(end)+0.381/2)*sin(theta) + init(1);
%         case 8
%             theta = asin(1.67/(sonars(1)+ 0.381 +sonars(end)));
%             y = (sonars(1)+0.381/2)*cos(theta) + init(2);
%     end;
    
    
end

% try
%     odom(2) = y + init(2);
% end

last_odom = odom;

var = [x,y,odom(3) + init(3)];
end

