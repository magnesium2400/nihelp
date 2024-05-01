function out = argout(f, n, m)
%% ARGOUT Return n-th output from a function
%% Input Arguments
% `f - function to get argument from (function handle)` Should not have any
% inputs. May be a good idea to input as an anonymous function of the desired
% computation (see examples). 
%
% `n - argument position to return (positive integer)`
%
% `m - number of outputs to request when calling f (positive integer)`
% default is `n`.
%
%
%% Examples
%   argout(@() max(magic(3)), 2)
%   argout(@() unique(magic(3)), 3)
%   argout(@() eig(magic(3)), 1, 2)
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%

if nargin < 3 || isempty(m); m = max(n); end

tmp = cell(1, m);
[tmp{1:end}] = f(); % evaluate function
out = tmp{n};

end

