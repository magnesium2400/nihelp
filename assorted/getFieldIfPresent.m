function out = getFieldIfPresent(structIn, fieldName)
%% GETFIELDIFPRESENT checks if a struct contains a field; if so, returns it
%% Examples
%   getFieldIfPresent(struct('a', 1, 'b', 2), 'a')
%   getFieldIfPresent(struct('a', 1, 'b', 2), 'c')
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


if isfield(structIn, fieldName)
    out = structIn.(fieldName); %getfield(structIn, fieldName);
else
    out = [];
end
end