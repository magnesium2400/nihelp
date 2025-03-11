function N = ndims1(A)
%% NDIMS1 Number of array dimensions, with possibly 0 or 1 dimensions
%% Syntax
%  N = ndims1(A)
%
%
%% Description
% `N = ndims(A)` returns the number of dimensions in the array A. The
% function ignores trailing dimensions, for which `size(A,dim) = 0` or
% `size(A,dim) = 1`.
%
%
%% Examples
%   ndims1(magic(5))
%   ndims1(1:5)
%   ndims1((1:5)')
%   ndims1([])
%
%
%% Input Arguments
% `A - input array (scalar | vector | matrix)` 
%
%
%% See Also
% `SIZE`, `LENGTH`, `NDIMS`
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%

N = ndims(A); 
if N > 2; return; end
if size(A,2) == 1; N = 1; end % column vector or scalar
if size(A,2) == 0; N = 0; end % empty vector

end