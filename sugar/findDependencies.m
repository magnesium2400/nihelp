function out = findDependencies(filename)
%% FINDDEPENDENCIES Finds dependencies for specified function, file, or folder
%% Examples
%   findDependencies('findDependencies')
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
