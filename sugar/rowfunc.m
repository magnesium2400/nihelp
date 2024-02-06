function out = rowfunc(func, data)
%% ROWFUNC Evaluates function on each row in a matrix
%% Examples
%   rowfunc( @(x) [max(x), min(x)] , magic(3))
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

out = colfunc(func, data.').';
end
