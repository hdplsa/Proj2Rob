function update_plots( h, x_store, x_ref_store, y_store, y_ref_store, t_store, v_store, w_store, time_store )
    
    set(h{1},'XData',time_store,'YData',x_ref_store);
    set(h{2},'XData',time_store,'YData',x_store);
    set(h{3},'XData',time_store,'YData',y_ref_store);
    set(h{4},'XData',time_store,'YData',y_store);
    set(h{5},'XData',time_store,'YData',t_store);
    set(h{6},'XData',time_store,'YData',v_store);
    set(h{7},'XData',time_store,'YData',w_store);
    set(h{8},'XData',x_store,'YData',y_store);
    
end

