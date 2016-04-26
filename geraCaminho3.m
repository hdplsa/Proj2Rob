function [px,py] = geraCaminho3(l1,l2,l3,d, DEBUG)
    
    if nargin == 0
        l1=3;
        l2=3;
        l3=14.5;
        d=0.5;
        DEBUG=1;
    elseif nargin < 4
        error('Not sufficient input variables');
    elseif nargin < 5
        DEBUG = 0;
    end
    
    close all;
    
    pontos = [0,0 ; l2/2,l1; l2,l1+d; l2,l3+l1-d; l2+d,l3+l1;
        l2+l3-d,l3+l1; l2+l3,l3-d+l1; l2+l3,d+l1; l2+l3-d,l1;
        l2/2,l1; 0,0];
    
    t = linspace(0,5*60,size(pontos,1));
    
    px = pchip(t,pontos(:,1));
    py = pchip(t,pontos(:,2));
    
    if DEBUG
        
        t = linspace(0,5*60,1000);
        
        ppx = ppval(px,t);
        ppy = ppval(py,t);
        
        figure; hold on;
        plot(pontos(:,1),pontos(:,2),'o');
        plot(ppx,ppy);
    end
    
end