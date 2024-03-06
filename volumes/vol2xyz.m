function [coords, data] = vol2xyz(V, mask)
%% vol2xyz Volumetric data in voxel coordinates to xyz coordinates
%% Examples
%   coords = vol2xyz(loadmri)
%   coords = vol2xyz(loadmri, logical(loadmri)); figure; scat3(coords);
%   [coords, data] = vol2xyz(loadmri, logical(loadmri)); figure; scat3(coords, [], data);
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


[x,y,z] = ndgrid(1:size(V,1),1:size(V,2),1:size(V,3));
if nargin < 2; mask = true(size(V)); end
coords = [x(mask(:)),y(mask(:)),z(mask(:))];
data = V(mask(:));
end
