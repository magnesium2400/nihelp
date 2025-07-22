function out = nz(X)
%% NZ Number of zeros
%% Examples
%   nz(pascal(3)-1)
out = numel(X)-nnz(X); 
end
