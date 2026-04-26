function [fwhm, Vm, Vs] = estimateFWHMlocal(mass, stiffness, data)
va = diag(mass); 
data = data - (va'*data)/sum(va); % set (mass-weighted) mean to 0
Vm = data .* (mass * data); 
if any(Vm<0); warning('Small Vm values detected'); Vm = abs(Vm); end 
Vs = data .* (stiffness * data) - 0.5*(stiffness*data.^2); 
fwhm = sqrt(8 * log(2) * Vm ./ Vs); 
end
