function out = nin(X)
%% NIN Number is nan
%% Examples
%   a = magic(3); a(:,1) = NaN; nin(a)
out = nnz(isnan(X)); 
end