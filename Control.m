function [ v, omega, e ] = Control( x,y,theta,xref,yref,v_last,w_last )
    %Controlador do robot
    
    vmax = 0.15;
    k1 = 1;
    k2 = 0.3;
    k3 = 5;
      
    e = sqrt((xref-x)^2+(yref-y)^2);
    phi = atan2((yref-y),(xref-x));
    alpha = phi-theta;
    
    % Por vezes o alpha vai para al�m de [-pi,pi) e portanto, como a lei de
    % controlo cont�m tangentes hiperb�licas (que n�o s�o peri�dicas), o
    % valor alpha+2*pi n�o � igual, portanto, tem que se corrigir.
    if alpha > pi
        while alpha > pi
            alpha = alpha - 2*pi;
        end
    elseif alpha < -pi
        while alpha < -pi
            alpha = alpha + 2*pi;
        end
    end
    
    if e > 1e-6 % Quando e == 0, v = NaN
        v = vmax*tanh(k1*e);
        omega = vmax*((1+k2*phi/alpha)*tanh(k1*e)/e*sin(alpha)+k3*tanh(alpha));
        if isnan(omega)
            omega = 0;
        end
    else
        v = 0;
        omega = 0;
    end
    
    % Impede que o controlador imponha controlos com varia��es bruscas,
    % colocando uma satura��o na varia��o entre ciclos
    
%     delta_v = 0.01;
%     delta_w = 0.01;
%     
%     if abs(v) > abs(v_last) + delta_v
%         v = v_last + sign(v)*delta_v;
%     elseif abs(v) < abs(v_last) - delta_v
%         v = v_last - sign(v)*delta_v;
%     end
%     
%     dif = omega - w_last;
%     
%     if dif >= delta_w
%         omega = w_last + delta_w;
%     elseif dif < - delta_w
%         omega = w_last - delta_w;
%     end
         
end

