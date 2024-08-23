function [out, rowOrder] = sortTriangulation(faces)
%% SORTTRIANGULATION Sorts triangulation whilst preserving orientation of faces
%% Examples
%   f = [4 2 3; 4 2 1], sortTriangulation(f)
%   f = delaunay([1 1; 1 2; 2 2; 2 1]), sortTriangulation(f)
%   v = table2array(combinations(1:3,1:3)); f = delaunay(v), sortTriangulation(f)
%   rng(1); v = rand(10,2); f = delaunay(v); sortTriangulation(f)
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


%%
[~,id] = min(faces, [], 2);

out = nan(size(faces)); 

for ii = 1:3
    out(id==ii,:) = faces(id==ii,mod(ii-1:ii+1,3)+1);
end

[out, rowOrder] = sortrows(out); 

end
