function [v,omega] = CorrectSonar(v,omega)

%Retorna vector de 8 posições com medidas dos sonares
sonar = pioneer_read_sonars();
%Processa distâncias - distâncias a obstáculos à esquerda, à direita e à
%frente
% sleft = sonar(1);
% sleftfront = sonar(2);
% sfront = 0.5*(sonar(4)+sonar(5));
% srightfront = sonar(7);
% sright = sonar(8);


%Retorna velocidades corrigidas em função dos sonares

%Caso esteja demasiado próximo, pára
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

