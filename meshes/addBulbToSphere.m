function [newVerts, bulbKernel] = addBulbToSphere(verts, vertexToAdd, kernelRadius, kernelHeight)
%% ADDBULBTOSPHERE Add distortion to (spherical) mesh at specified location
%% Examples
%   [v,f]=sphereMesh; tmp=@(v,f) patch('Vertices',v,'Faces',f,'FaceColor','none'); figure; nexttile; tmp(v,f); v2=addBulbToSphere(v,1:100:301,.1,.2); nexttile; tmp(v2,f);      
%   [v,f]=torusMesh; tmp=@(v,f) patch('Vertices',v,'Faces',f,'FaceColor','none'); figure; nexttile; tmp(v,f); v2=addBulbToSphere(v,[2 0 0;-2 0 0],.1,.1); nexttile; tmp(v2,f);      
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



if isvector(vertexToAdd); vertexToAdd = verts(vertexToAdd,:); end
if nargin < 3; kernelRadius = 1000; end
if nargin < 4; kernelHeight = 1/4; end

dists = pdist2(verts, vertexToAdd, 'squaredeuclidean');
bulbKernel = 1 + kernelHeight*exp(-dists/kernelRadius);
newVerts = verts; 
for ii = 1:size(bulbKernel,2); newVerts = newVerts .* bulbKernel(:,ii); end
% newVerts = (verts .* bulbKernel(:,1)) .* bulbKernel(:,2); % implicit expansion
end