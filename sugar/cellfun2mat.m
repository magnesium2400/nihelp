function out = cellfun2mat(func, C)
%% CELLFUN2MAT Returns output from cellfun as a matrix
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


out = cell2mat(cellfun(func,C, 'UniformOutput', false));
end