function [fwhm, Vm, Vs] = estimateFWHM(mass, stiffness, data)
[~,Vm,Vs] = estimateFWHMlocal(mass, stiffness, data); 
Vm = sum(Vm, 1); 
Vs = sum(Vs, 1); 
fwhm = sqrt(8 * log(2) * Vm ./ Vs); 
end
