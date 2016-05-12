function [ p ] = sim_sonares( x,y,theta,paredes )
    %SIM_SONARES Simula os sonares do robo
    %   Atrav�s da posi��o e orienta��o do robo e da esqua��o das paredes,
    %   calcula a dist�ncia medida pelos sonares
    
    % A estrutura paredes deve ser um cell array de 2 elementos, cada um
    % com um vetor de 2 elementos que descreve a equa��o da reta feita por
    % cada uma das paredes ex: [0;1] indica que h� uma parede com equa��o 
    % y = 0, x = 1; [1; 2] indica que h� uma parede 1*y = 2*x.
    
    for i = 1:2
       
        if paredes{i}(1) == 0
            
            ay = y + cos(theta)*(x+ paredes{i}(2));
            p(:,i) = [ay;paredes{i}(2)];
            
        elseif paredes{i}(2) == 0
            
            ax = (paredes{i}(1)-y)/cos(theta)-x;
            p(:,i) = [paredes{i}(1);ax];
            
        else
            
            gamma = paredes{i}(2)/paredes{i}(1);
            ax = (y+cos(theta)*x)/(gamma-cos(theta));
            ay = y+cos(theta)*(ax+x);
            p(:,i) = [ay;ax];
            
        end
        
    end
    
    
end

