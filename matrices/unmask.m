function out = unmask(mask, data, fillVal)
%% UNMASK Adds empty rows to data (which may have been removed previously)
%% Examples
%   unmask([1 0 1 0 1 0], (1:3)')
%   unmask([1 0 1 0 1 0 1 0]', magic(4), 0)
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

assert((nnz(mask) == size(data, 1))); 
if nargin < 3 || isempty(fillVal); fillVal = nan; end

out = ones(numel(mask), size(data, 2)) * fillVal; 
out(logical(mask(:)),:) = data; 

end
