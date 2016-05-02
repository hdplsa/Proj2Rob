function [ei] = integrateErro(e,h)
%Cria o integral do erro

ei = zeros(1,length(e));
%Integração de Euler (y'(t0) = (y(t0+h)-y(t0))/h)
for n=2:length(e)
    ei(n) = e(n-1)*h+ei(n-1);
end

figure();
t = linspace(0,5,length(e));
subplot(2,1,1);
plot(t,e);
title('e');
subplot(2,1,2);
plot(t,ei);
title('ei');

end

