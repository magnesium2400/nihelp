function out = argout(f, n)
%% ARGOUT Return n-th output from a function
%% Input Arguments
% `f - function to get argument from (function handle)` Should not have any
% inputs. May be a good idea to input as an anonymous function of the desired
% computation (see examples). 
%
% `n - argument position to return (positive integer)`
%
%
%% Examples
%   argout(@() max(magic(3)), 2)
%   argout(@() unique(magic(3)), 3)
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%

tmp = cell(1, max(n));
[tmp{1:end}] = f(); % evaluate function
out = tmp{n};

end

