function sendData(obj, event, sp, caminho, omega)
    %Função de callback que envia dados para o robot (não alterar
    %declaração!!!)
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
    %Verifica referência anterior
    xref = x_ref_store(i-1);
    yref = y_ref_store(i-1);
    
    %Verifica posição onde se encontra
    [x,y,theta] = get_odom2();
    
    %Encontra próximo ponto do caminho para onde convergir
    [xref, yref, aux] = assign_reference(x,y,xref,yref, caminho(:,j:end));
    j = j + aux;
    
    %Determina velocidades pelo algoritmo de controlo
    [v,omega,e] = Control(x,y,theta,xref,yref,v_store(i-1),w_store(i-1));
    
    %Corrige velocidades através dos sonares
    [v,omega] = CorrectSonar(v,omega);
    
    pioneer_set_controls(sp,round(v*1000),round(omega*180/pi));
    
    %Grava valores nos vectores
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
    
    %Mostra evolução no gráfico
    update_plots(x_store, y_store, t_store);
    
    fprintf('Ciclo %d\n',i);
    
end

