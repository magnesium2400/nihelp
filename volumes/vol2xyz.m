function [coords, data] = vol2xyz(V)
%% vol2xyz volumetric data to xyz coordinates
[x,y,z] = ndgrid(1:size(V,1),1:size(V,2),1:size(V,3));
coords = [x(:),y(:),z(:)];
data = V(:);
end
