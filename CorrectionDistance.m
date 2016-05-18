function [d] = CorrectionDistance(zona,lc,lr,ld,sonars)
%Retorna as distancias minimas e maximas em que a posi��o deve ser
%corrigida

%Valores default, de inicializa��o
% dmin = lc-ld;
% dmax = 2360/1000;
d = false;
%Verifica distancia para a frente pela m�dia dos dois sonares centrais
sonf = (sonars(4)+sonars(5))*0.5;
%Orienta��o do robot no corredor sem aberturas
theta = get_orientation(lc,lr,sonars);
%Verifica aberturas (Aplica��o da lei dos cossenos)
gamma = pi/2-theta;
a = sonar(1); b = 2*a*cos(gamma);
c = sqrt(a^2+b^2-2*a*b*cos(gamma));
%Condi��o natural do corredor (sem aberturas): corrige
if((c >= 0.9*sonf) && (c <= 1.1*sonf))
    d = true;
else
    %%Testes para situa��es particulares
    %Aberturas laterais: n�o corrige (no futuro, pode corrigir com base no
    %outro lado apenas)
    if((sonars(1) >= 2*sonars(end))||(sonars(1) <= 2*sonars(end)))
       d = false; 
    end
    %Pernas dos bancos: n�o corrige
    if(sonars(1)+lr+sonars(end) < lc)
       d = false; 
    end
end
        
