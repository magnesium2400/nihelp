function [coords, data] = vol2xyz(V, mask)
%% vol2xyz volumetric data to xyz coordinates
[x,y,z] = ndgrid(1:size(V,1),1:size(V,2),1:size(V,3));
if nargin < 2; mask = true(size(V)); end
coords = [x(mask(:)),y(mask(:)),z(mask(:))];
data = V(mask(:));
end
