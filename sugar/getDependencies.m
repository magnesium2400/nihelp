function out = getDependencies(filename)
%% GETDEPENDENCIES Finds dependencies for specified function, file, or folder
%% Examples
%   getDependencies('getDependencies')
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

out = reshape( matlab.codetools.requiredFilesAndProducts(filename) ,[],1);
end
