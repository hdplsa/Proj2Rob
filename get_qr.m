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
    % necessary to adjust the conditions in the if...else...end
    
    frame = ycbcr2rgb(frame);
    image( frame );
    
    colormap jet
    
    % the decoder only works for RGB images
    message = QRcode.decode_qr( frame );
    if isempty(message)==0
        disp( message );
        new_msg = 1;
        beep,
    end
    
    
end

