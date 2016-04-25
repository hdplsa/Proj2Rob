function [ v, omega ] = Control( x,y,theta,xref,yref )
 %Controlador do robot
    
    vmax = 0.35;
    k1 = 1;
    k2 = 0.5; 
    k3 = 2;
    
    e = sqrt((xref-x)^2+(yref-y)^2);
    phi = atan2((yref-y),(xref-x));    
    alpha = phi-theta;
    
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
    
end

