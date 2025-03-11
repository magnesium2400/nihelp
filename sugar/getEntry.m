function out = getEntry(data, idx)
%% GETENTRY Get entry from cell or matrix (linear indexing)
%% Examples
%   getEntry(magic(3), 5)
%   getEntry(num2cell(magic(3)), 5)
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

if       iscell(data); out = data{idx}; 
elseif ismatrix(data); out = data(idx); end
end
