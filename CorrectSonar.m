function [v,omega] = CorrectSonar(v,omega)

%Retorna vector de 8 posi��es com medidas dos sonares
sonar = pioneer_read_sonars();
%Processa dist�ncias - dist�ncias a obst�culos � esquerda, � direita e �
%frente
% sleft = sonar(1);
% sleftfront = sonar(2);
% sfront = 0.5*(sonar(4)+sonar(5));
% srightfront = sonar(7);
% sright = sonar(8);


%Retorna velocidades corrigidas em fun��o dos sonares

%Caso esteja demasiado pr�ximo, p�ra
for n=1:8
    if (sonar(n) <= 250)
       v = 0; omega = 0; 
    end
end

%Caso se esteja a aproximar de uma parede, aumenta velocidade angular
%(simples ganho)
if (sonar(2) < 400 || sonar(3) < 400 || sonar(6) < 400 || sonar(7) < 400)
    omega = 2*omega;
end

end

