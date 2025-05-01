function [newA, newB] = impex(A, B)
%% IMPEX Uses implicit expansion to "broadcast" matrices
%% Examples
%   a=zeros(2,3,4); b=randn(1,1,1); assert(all( impex(b,a) == repmat(b,[2 3 4]) ,'all')); 
%   a=zeros(2,3,4); b=randn(1,1,4); assert(all( impex(b,a) == repmat(b,[2 3 1]) ,'all')); 
%   a=zeros(2,3,4); b=randn(1,3,1); assert(all( impex(b,a) == repmat(b,[2 1 4]) ,'all')); 
%   a=zeros(2,3,4); b=randn(2,1,1); assert(all( impex(b,a) == repmat(b,[1 3 4]) ,'all')); 
%   a=zeros(2,3,4); b=randn(1,3,4); assert(all( impex(b,a) == repmat(b,[2 1 1]) ,'all')); 
%   a=zeros(2,3,4); b=randn(2,1,4); assert(all( impex(b,a) == repmat(b,[1 3 1]) ,'all')); 
%   a=zeros(2,3,4); b=randn(2,3,1); assert(all( impex(b,a) == repmat(b,[1 1 4]) ,'all')); 
%   a=zeros(2,3,4); b=randn(2,3,4); assert(all( impex(b,a) == b ,'all')); 
%   
%   
%   
%% See Also
%   https://au.mathworks.com/help/matlab/matlab_prog/compatible-array-sizes-for-basic-operations.html
%   areCompatible, getImpex
%
%
%% TODO
% * docs
%
%
%% Authors
% Mehul Gajwani, Monash University, 2025
%
%

[c, ~, sza, szb] = areCompatible(A, B);
assert(c, 'Array sizes are not compatible');

szout = max(sza, szb); 
newA = repmat(A, szout./sza); 

if nargout<2; return; end
newB = repmat(A, szout./szb); 

end
