function sendData(obj, event, sp, caminho, omega)
    %Fun��o de callback que envia dados para o robot (n�o alterar
    %declara��o!!!)
    %http://www.mathworks.com/help/matlab/creating_plots/callback-definition.html
    
    global x_store y_store t_store v_store w_store x_ref_store y_ref_store e_store;
    
    persistent j i;
    
    if isempty(j)
        j = 1;
    end
    
    if isempty(i)
        i = 2;
    else
        i = i+1;
    end
    
    xref = x_ref_store(i-1);
    yref = y_ref_store(i-1);
    
    odom = get_odom();
    x = odom(1); y = odom(2); theta = odom(3);
    
    [xref, yref, aux] = assign_reference(x,y,xref,yref, caminho(:,j:end));
    j = j + aux;
    
    [v, omega,e] = Control(x,y,theta,xref,yref,v_store(i-1),w_store(i-1));
    
    pioneer_set_controls(sp,round(v*1000),round(omega*180/pi));
    
    
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
    
    update_plots(x_store, y_store, t_store);
    
    fprintf('Ciclo %d\n',i);
    
end

