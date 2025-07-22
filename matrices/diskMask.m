function out = diskMask(radius, sz)
%% DISCMASK Generate an ellipsoidal mask of given axes lengths
%% Examples
%   diskMask(1)
%   diskMask(4)
%   diskMask(2,7)
%   diskMask([2,3])
%   diskMask([2,3],[7,9])
%   diskMask(0,5)
%   figure; imagesc(diskMask(99)); axis('image'); 
%   figure; imagesc(diskMask([99,199])); axis('image'); 
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

if nargin < 2 || isempty(sz); sz = radius*2+1; end

h = sz(1); w = sz(end); 
out = false(h,w); 

[x,y] = meshgrid( -(w-1)/2:(w-1)/2 , -(h-1)/2:(h-1)/2 );
d = (x/(radius(end)+eps)).^2 + (y/(radius(1)+eps)).^2; % add eps in case radius is 0
out(d<=1) = true; 


end
