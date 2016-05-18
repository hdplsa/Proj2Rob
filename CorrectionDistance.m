function [d] = CorrectionDistance(zona,lc,lr,ld,sonars)
%Retorna as distancias minimas e maximas em que a posição deve ser
%corrigida

%Valores default, de inicialização
% dmin = lc-ld;
% dmax = 2360/1000;
d = false;
%Verifica distancia para a frente pela média dos dois sonares centrais
sonf = (sonars(4)+sonars(5))*0.5;
%Orientação do robot no corredor sem aberturas
theta = get_orientation(lc,lr,sonars);
%Verifica aberturas (Aplicação da lei dos cossenos)
gamma = pi/2-theta;
a = sonar(1); b = 2*a*cos(gamma);
c = sqrt(a^2+b^2-2*a*b*cos(gamma));
%Condição natural do corredor (sem aberturas): corrige
if((c >= 0.9*sonf) && (c <= 1.1*sonf))
    d = true;
else
    %%Testes para situações particulares
    %Aberturas laterais: não corrige (no futuro, pode corrigir com base no
    %outro lado apenas)
    if((sonars(1) >= 2*sonars(end))||(sonars(1) <= 2*sonars(end)))
       d = false; 
    end
    %Pernas dos bancos: não corrige
    if(sonars(1)+lr+sonars(end) < lc)
       d = false; 
    end
end
        
