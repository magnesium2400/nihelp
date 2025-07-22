function out = density_und(X)
%% DENSITY_UND Finds the density of a connectome
%% Examples
%   density_und(mod(magic(3),3)==1)
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2025
% 
% 

out = ( nnz(X)-nnz(diag(X)) ) / ( numel(X)-numel(diag(X)) );
end

