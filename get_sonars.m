function [sleft,sfront,sright] = get_sonars()
%Retorna a leitura dos sonares do robot

%Retorna vector de 8 posi��es com medidas dos sonares
sonar = pioneer_read_sonars();
%Processa dist�ncias - dist�ncias a obst�culos � esquerda, � direita e �
%frente
sleft = 10000;
sfront = 0.5*(sonar(4)+sonar(5));
sright = 10000;

end

