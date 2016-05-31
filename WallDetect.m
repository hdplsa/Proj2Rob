function [parede] = WallDetect(sonars,lc)
%Detecta uma parede à frente do robot

%Média dos 4 sensores frontais
meanfront = sum(sonars(4:5));
meanfront = meanfront/length(sonars(4:5));
%fprintf('A distância é %g\n',meanfront);
%Condição de detecção de parede
if((meanfront >= 0.95*lc)&&(meanfront <= 1.15*lc))
    %Condição de sensores laterais
    if((sonars(end) > 1))
        parede = true;
        fprintf('Cheguei à viragem, distancia: %g\n',meanfront);
    else
        parede = false;
    end
else
    parede = false;
end

end

