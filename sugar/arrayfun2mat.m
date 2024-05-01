function out = arrayfun2mat(func, C)
%% ARRAYFUN2MAT Returns output from arrayfun as a matrix
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


out = cell2mat(arrayfun(func,C, 'UniformOutput', false));
end