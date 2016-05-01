function update_plots( x_store, y_store, t_store )

    
    % Vai pegar nas variáveis globais que contêm os plots
    global h1 h2 h3;
    
    %set(h1,'XData',time,'YData',y_store);
    
    % Modifica os dados pertencentes a cada 
    set(h3,'XData',x_store,'YData',y_store);
    
    
end

