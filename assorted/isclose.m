function out = isclose(a, b, tol)
%% ISCLOSE Checks whether two values are close to each other, or not
%% Examples
%   isclose(1e-9, 1e-10)
%   isclose(1e-9, -1e-10)
%   isclose(1e-9, -1e-10, 2e-9)
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


if nargin < 3; tol = 1e-09; end
out = abs(a-b)<tol;
end