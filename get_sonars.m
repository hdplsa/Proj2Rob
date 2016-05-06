function [sleft,sfront,sright] = get_sonars()
%Retorna a leitura dos sonares do robot

%Retorna vector de 8 posições com medidas dos sonares
sonar = pioneer_read_sonars();
%Processa distâncias - distâncias a obstáculos à esquerda, à direita e à
%frente
sleft = 10000;
sfront = 0.5*(sonar(4)+sonar(5));
sright = 10000;

end

