function out = allclose(a,b,tol,flag)
%% ALLCLOSE Checks whether all values are close to each other, or not
%% Examples
%   allclose((1:10)+1e-9, (1:10)+1e-10)
%   allclose((1:10)+1e-9, (1:10)-1e-10)
%   allclose((1:10)+1e-9, (1:10)-1e-10, 2e-9)
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

if nargin < 2 || isempty(b);    b = 0;          end
if nargin < 3 || isempty(tol);  tol = 1e-09;    end
if nargin < 4 || isempty(flag); flag = '';      end

% improves performance on sparse matrices
d = abs(nonzeros(a-b)); 

if strcmp(flag, 'omitnan') % equality comparison with nan is always false
    out = all( ~(d>tol) , 'all'); 
else
    out = all(   d<=tol , 'all');
end

out = full(out); 

end
