function out = isequalTriangulation(f, f2)
%% ISEQUALTRIANGULATION Compares two triangulations, including face orientations
%% Usage Notes
% * Returns `1` if all faces are the same, and all in the same orientation
% * Returns `-1` if all faces are the same, and all in the opposite orientation
% * Returns `0` otherwise
%
%
%% Examples
%   [v,f] = sphereMesh; g = f(randperm(height(f)),:); isequalTriangulation(f,g)
%   [v,f] = sphereMesh; g = f(randperm(height(f)),:); assert(~isequal(f,g) & isequalTriangulation(f,g))
%   [v,f] = sphereMesh; g = f(:,[1 3 2]); assert(isequalTriangulation(f,g)==-1)
%   [v,f] = sphereMesh; g = f; g(1:end/2,:) = g(1:end/2,[1 3 2]); assert(isequalTriangulation(f,g)==0)
% 
% 
%% TODO
% * docs
% 
% 
%% See Also
% sortTriangulation, ismemberTriangulation, sortTriangulationFaces
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


if isequal(sortTriangulation(f), sortTriangulation(f2))
    out = 1;
elseif isequal(sortTriangulation(f), sortTriangulation(f2(:,[1,3,2]))) 
    out = -1; 
else
    out = 0; 
end


end
