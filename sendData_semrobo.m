function sendData(obj, event, sp, caminho)
%Função de callback que envia dados para o robot (não alterar
%declaração!!!)
%http://www.mathworks.com/help/matlab/creating_plots/callback-definition.html

    global x_store y_store t_store v_store w_store x_ref_store y_ref_store e_store x y theta t;

    persistent j i;
    
    if isempty(j)
        j = 1;
    end
    
    if isempty(i)
        i = 2;
    else
        i = i + 1;
    end
    
    xref = x_ref_store(i-1);
    yref = y_ref_store(i-1);

    t = 10e-2;
    
    [xref, yref, aux] = assign_reference(x,y,xref,yref, caminho(:,j:end));
    j = j + aux;
    
    [v, omega,e] = Control(x,y,theta,xref,yref,v_store(i-1),w_store(i-1));
    [x,y,theta] = Kinematics(v,omega,x,y,theta,t);

    %robot.pioneer_set_controls(sp,round(v*1000),round(omega*1000));
    
    x_store(i) = x;
    y_store(i) = y;
    t_store(i) = theta;
    v_store(i) = v;
    w_store(i) = omega;
    e_store(i) = e;
    
    x_ref_store(i) = xref;
    y_ref_store(i) = yref;
    
    if size(caminho(:,j:end),2) == 0
        stop(tim);
    end

    disp(sprintf('ciclo %i',i));
    
    update_plots(x_store, y_store, t_store);
    
end

