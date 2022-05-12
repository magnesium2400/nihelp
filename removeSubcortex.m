function [out, edgesKept] = removeSubcortex(in)
%REMOVESUBCORTEX removes subcortex with MANY implicit assumptions
%   if in == 68*68, assume Desikan Killiany and do nothing
%   if in == 82*82, assume Desikan Killiany and remove 35-42 and 75-82
%   if in == 200*200, assume Schaefer and do nothing
%   if in == 220*220, assume Schaefer and remove 101-110 and 211-220
%   if in == 360*360, assume Glasser and do nothing
%   if in == 380*380, assume Glasser and remove 181-190 and 351-360

assert(ismatrix(in), "input must be a matrix"); 
assert(size(in,1) == size(in,2), "input must be square");

allowedN =      [68,    82,     200,    220,    360,    380,    500,    520]';
subCortLength = [0,     14,     0,      20,     0,      20,     0,      20]';

N = size(in,1); 
assert(ismember(N, allowedN), "input not appropriate size");
NS = subCortLength(allowedN == N); %N_subcortex
NC = N - NS; %N_cortex

if NS == 0
    warning("Using removeSubcortex function, no subcort found, no changes made");
else
    warning("Using removeSubcortex function, needs close attention");
end

edgesKept = zeros(size(in));

toBeKept = [(1:NC/2), (NC/2+NS/2+1):(NC+NS/2)];
edgesKept(toBeKept, toBeKept) = 1;
out = reshape(in(logical(edgesKept)), NC, NC);

end