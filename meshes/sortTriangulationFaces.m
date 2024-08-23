function [out, id] = sortTriangulationFaces(faces)
%% SORTTRIANGULATION Sorts each face in triangulation whilst preserving orientation 
%% Examples
%   f = [4 2 3; 4 2 1], sortTriangulationFaces(f)
%   f = delaunay([1 1; 1 2; 2 2; 2 1]), sortTriangulationFaces(f)
%   v = table2array(combinations(1:3,1:3)); f = delaunay(v), sortTriangulationFaces(f)
%   rng(1); v = rand(10,2); f = delaunay(v); sortTriangulationFaces(f)
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

end
