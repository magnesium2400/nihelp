function [tf, nans] = allclosen(a,b,tol,fn)
%% ALLCLOSEN Determines if all non-NaN elements are within a specified tolerance
%% Examples
%   tf = allclosen(1e-13)
%   tf = ~allclosen(NaN)
%   tf = allclosen(NaN, NaN)
%   tf = allclosen(NaN, NaN, [], @or)
%   tf = ~allclosen(NaN, NaN, [], @xor)
%   tf = allclosen(1e-13, 2e-13)
%   tf = allclosen([1 NaN], [1 NaN])
%   tf =  allclosen([1 NaN], [1 1], [], @or)
%   tf = ~allclosen([1 NaN], [1 1], [], @and)
%
%

if nargin < 2 || isempty(b);    b = 0;          end
if nargin < 3 || isempty(tol);  tol = 1e-09;    end
if nargin < 4 || isempty(fn);   fn = @and;      end

d = abs(a-b);
nans = fn(isnan(a), isnan(b)); 
d = d(~nans);
tf = all(d<=tol, 'all');

end
