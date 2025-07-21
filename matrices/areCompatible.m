function [out, nd, sza, szb] = areCompatible(A, B)
%% ARECOMPATIBLE Checks if arrays are compatible sizes
%% Examples
%   a=zeros(2,3,4); b=zeros(1,1,1); assert(areCompatible(a,b)); 
%   a=zeros(2,3,4); b=zeros(1,1,4); assert(areCompatible(a,b)); 
%   a=zeros(2,3,4); b=zeros(1,3,1); assert(areCompatible(a,b)); 
%   a=zeros(2,3,4); b=zeros(2,1,1); assert(areCompatible(a,b)); 
%   a=zeros(2,3,4); b=zeros(1,3,4); assert(areCompatible(a,b)); 
%   a=zeros(2,3,4); b=zeros(2,1,4); assert(areCompatible(a,b)); 
%   a=zeros(2,3,4); b=zeros(2,3,1); assert(areCompatible(a,b)); 
%   a=zeros(2,3,4); b=zeros(2,3,4); assert(areCompatible(a,b)); 
%   
%   a=zeros(2,3,4); b=zeros(2,3,2); assert(~areCompatible(a,b)); 
%   a=zeros(2,3,4); b=zeros(2,3,8); assert(~areCompatible(a,b)); 
%   
%   a=zeros(1,1,2,3); b=zeros(1);       assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(4,1);     assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(1,5);     assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(4,5);     assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(4,1,2);   assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(1,5,2);   assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(4,5,2);   assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(4,1,1,3); assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(1,5,1,3); assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(4,5,1,3); assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(4,1,2,3); assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(1,5,2,3); assert(areCompatible(a,b)); 
%   a=zeros(1,1,2,3); b=zeros(4,5,2,3); assert(areCompatible(a,b)); 
%   
%   
%   
%% See Also
%   https://au.mathworks.com/help/matlab/matlab_prog/compatible-array-sizes-for-basic-operations.html
%   impex, getImpex
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

nd = max(ndims(A), ndims(B)); 
sza = size(A, 1:nd); 
szb = size(B, 1:nd); 
out = all( sza==1 | szb==1 | sza==szb );

end

