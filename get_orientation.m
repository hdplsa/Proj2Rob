function [theta] = get_orientation(lc,lr,sonars)
%Retorna orienta��o do robot no corredor

theta = acos(lc/(sonars(1)+ lr +sonars(end)));

end

