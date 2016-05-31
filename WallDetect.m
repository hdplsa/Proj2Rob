function [parede] = WallDetect(sonars,lc)
%Detecta uma parede � frente do robot

%M�dia dos 4 sensores frontais
meanfront = sum(sonars(4:5));
meanfront = meanfront/length(sonars(4:5));
%fprintf('A dist�ncia � %g\n',meanfront);
%Condi��o de detec��o de parede
if((meanfront >= 0.95*lc)&&(meanfront <= 1.15*lc))
    %Condi��o de sensores laterais
    if((sonars(end) > 1))
        parede = true;
        fprintf('Cheguei � viragem, distancia: %g\n',meanfront);
    else
        parede = false;
    end
else
    parede = false;
end

end

