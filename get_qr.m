function get_qr(obj, event)
    
    global message new_msg;
    persistent cam;
    
    if isempty(cam)
        
        cam = webcam(1); 
         
    end
    
    frame = snapshot(cam);
    
    % the builtin webcam uses the YCbCr colorspace
    %
    % the number of the this webcam is not always the same so it may be
    % necessary to adjust the conditions in the if el se...end
    
%     frame = ycbcr2rgb(frame); 
    %imshow( frame ); 
    
    %colormap gray
    
    % the decoder only works for RGB images
    mes = QRcode.decode_qr( frame );
    disp(mes);
    if isempty(mes)==0
        disp( mes );
        message = mes;
        new_msg = 1;
        beep,
    end
    
end

