function [out,r] = calcRoiMedioid(verts, DISTANCE)
%% CALCROIMEDIOID returns the ID of the point in the pointcloud closest to the centroid
%% Examples
%   v = randn(100,3); m = calcRoiMedioid(v); figure; scatter3(v(:,1),v(:,2),v(:,3),[],(1:100).'==m,'filled'); 
%   [x,y]=meshgrid(1:20); z=(x-10).^2/10+(y-10).^2/10+peaks(20); v=[x(:),y(:),z(:)]; m=calcRoiMedioid(v); figure; scat3(v,[],(1:400).'==m,'filled'); hold on; scat3(mean(v)); axis equal;
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



assert(size(verts, 2) == 3);
if nargin < 2; DISTANCE = 'squaredeuclidean'; end
[r,out] = pdist2(verts, mean(verts), DISTANCE, 'Smallest', 1);

end