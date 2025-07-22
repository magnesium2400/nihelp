function out = cellfun2mat(func, varargin)
%% CELLFUN2MAT Returns output from cellfun as a matrix
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


out = cell2mat(cellfun(func, varargin{:}, 'UniformOutput', false));
end