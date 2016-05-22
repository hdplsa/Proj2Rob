function [pontos, paredes] = geraCaminho3(l1,l2,l3,d, DEBUG)

    %largura do robot
lc = 1.67;
lr = 0.270;
ld = 0.456;
corredor = 1.67;
    
if nargin == 0
    l1=3;
    l2=3;
    l3=15.7;
    d=1.67;
    DEBUG=1;
elseif nargin < 4
    error('Not sufficient input variables');
elseif nargin < 5
    DEBUG = 0;
end

close all;

%     pontos = [0,0 ; l1-d/2 l2-d; l1 l2-d/2; l1+l3 l2-d/2; l1+l3+d/2 l2;
%         l1+l3+d/2 l2+l3; l1+l3 l2+l3+d/2; l1 l2+l3+d/2; l1-d/2 l2+l3;
%         l1-d/2 l2-d; 0 0];


% pontos = [0,0 ; l1-d/2 l2-d; l1 l2-d/2; l1+l3/2 l2-d/2; l1+l3 l2-d/2; l1+l3+d/2 l2; l1+l3+d/2 l2+l3/2;
%     l1+l3+d/2 l2+l3; l1+l3 l2+l3+d/2; l1+l3/2 l2+l3+d/2; l1 l2+l3+d/2; l1-d/2 l2+l3; l1-d/2 l2+l3/2;
%     l1-d/2 l2-d; 0 0];

pontos = [0,0 ;0.3*4 0.3*4; l1-d/2 l2-d; l1 l2-d/2; l1+l3 l2-d/2; l1+l3+d/2 l2; 
    l1+l3+d/2 l2+l3; l1+l3 l2+l3+ld+(d-ld)*0.5;  l1 l2+l3+ld+(d-ld)*0.5;  0.3*4 0.3*12+l3+d; 0.3*4 0.3*12+d;
    0.3*4 0.3*4; 0 0];

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
    
    % fazer plot do rectângulo central da torre
    
    x = [ l1 l1 l1+l3 l1+l3 l1];
    y = [l2 l2+l3 l2+l3 l2 l2];
    
    plot(x,y);
    
    % quadrado exterior
    
    x = [ l1-d l1-d l1+l3+d l1+l3+d l1 ];
    y = [l2 l2+l3+d l2+l3+d l2-d l2-d];
    
    plot(x,y);
end

end