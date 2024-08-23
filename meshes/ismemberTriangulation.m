function out = ismemberTriangulation(sample, template)
%% ISEQUALTRIANGULATION Compares triangulations and their orientations
%% Usage Notes
% For a sample triangulation of `f` faces, the output will be an `f x 1` vector:
% values of 1 mean that the face is found in the template, values of -1 mean
% that the face is found with the opposite orientation, and values of 0 mean
% that the face is not found. 
%
%
%% Examples
%   ismemberTriangulation([1 2 3], [1 2 3])
%   rng(1); f=delaunay(rand(9,2)); x=ismemberTriangulation(f,f); assert(all(x==1));  
%   rng(1); f=delaunay(rand(9,2)); x=ismemberTriangulation(f,f(randperm(12),:)); assert(all(x==1)); 
%   rng(1); f=delaunay(rand(9,2)); x=ismemberTriangulation(f,f(:,[1,3,2])); assert(all(x==-1)); 
%   rng(1); f=delaunay(rand(9,2)); x=ismemberTriangulation(f,f(randperm(12),[1,3,2])); assert(all(x==-1));  
%
%   v=table2array(combinations(1:3,1:3)); f1=delaunay(v); v2=v+v(:,1); f2=delaunay(v2); ismemberTriangulation(f1,f2); 
%   v=table2array(combinations(1:3,1:3)); f1=delaunay(v); v2=v+v(:,1); f2=delaunay(v2); ismemberTriangulation(f1,f2(:,[1,3,2])); 
%
%   rng(1); f=delaunay(rand(9,2)); x=ismemberTriangulation(f,sortTriangulation(f)); assert(all(x==1)); 
%   rng(1); f=delaunay(rand(9,2)); x=ismemberTriangulation(f(:,[1,3,2]),sortTriangulation(f)); assert(all(x==-1));  
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


sample   = sortTriangulationFaces(sample); 
template = sortTriangulationFaces(template); 

% Find faces with same orientation (return if all same)
out = ismember(sample, template, "rows");
if all(out); return; end

% Find faces with reverse orientation
out = out - ismember(sample, template(:,[1,3,2]), "rows");

end
