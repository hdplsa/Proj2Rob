function send_data(obj, event, sp)
%Fun��o de callback que envia dados para o robot (n�o alterar
%declara��o!!!)
%http://www.mathworks.com/help/matlab/creating_plots/callback-definition.html

    global v omega v_act omega_act;
    
    v_act = v;
    omega_act = omega;
    
end

