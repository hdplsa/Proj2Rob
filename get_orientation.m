function [theta] = get_orientation(lc,lr,sonars)
%Retorna orientação do robot no corredor

theta = acos(lc/(sonars(1)+ lr +sonars(end)));

end

