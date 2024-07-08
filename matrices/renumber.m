function X = renumber(X, new, old)
%% RENUMBER Replace values in matrix
%% Examples
%   renumber(eye(3), 2)
%   renumber(eye(3), 2, 1)
%   renumber(magic(3), 10, 1)
%   renumber(magic(3), 10:20:90, 1:2:9)
%   renumber(magic(4), 10*(1:16), 1:16)
%   renumber(magic(3)+cat(3,0,1,2,3), 10*(1:12), 1:12)
% 
% 
%% TODO
% * docs
% 
% 
%% See Also 
%  CHANGEM
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 

if nargin < 3; old = 0; end
n = ndims(X)+1; 
d = @(v) permute(v(:), [2:n, 1]);               % use the nth dimension
t = X == d(old);                                % mask of values to remove
X = X - sum(t.*d(old),n) + sum(t.*d(new),n);    % remove and add new
end