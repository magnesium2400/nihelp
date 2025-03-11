function out = volumetricNeighbors(mask, V, kernel)
%% VOLUMETRICNEIGHBORS Finds the data in a volume V adjacent to a mask 
%% Examples
%   m=reshape(idx2mask(14,27),[3 3 3]); V=reshape(1:27,[3 3 3]); volumetricNeighbors(m,V)  
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


if nargin < 3 || isempty(kernel)
    kernel = zeros(3,3,3);
    kernel([5 11 13 14 15 17 23]) = 1; % orthogonal only
end

maskDilated = imdilate(mask, kernel) & ~mask;
out = V(maskDilated);
% [n,g] = groupcounts(out); 

end