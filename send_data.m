function send_data(obj, event, sp)
%Função de callback que envia dados para o robot (não alterar
%declaração!!!)
%http://www.mathworks.com/help/matlab/creating_plots/callback-definition.html

    global v omega v_act omega_act;
    
    v_act = v;
    omega_act = omega;
    
end

