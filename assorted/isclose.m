function out = isclose(a, b, tol)
if nargin < 3; tol = 1e-7; end
out = abs(a-b)<tol;
end