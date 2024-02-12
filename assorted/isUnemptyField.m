function out = isUnemptyField(structIn, fieldName)
%% ISUNEMPTYFIELD returns true iff field is present and not empty
%% Examples
%   isUnemptyField(struct('a', [], 'b', 2), 'a')
%   isUnemptyField(struct('a', 11, 'b', 2), 'a')
%   isUnemptyField(struct('a', 11, 'b', 2), 'c')
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


out = isfield(structIn, fieldName) && ~isempty(structIn.(fieldName));
end
