function [out] = isContiguous(volumetricRegion, thr)
%% ISCONTIGUOUS Compute whether all points in a volumetric region are connected
%% Examples
%   isContiguous(magic(4)>4)
%   isContiguous(magic(4)>5)
%   isContiguous(magic(4)>5, sqrt(2))
%   isContiguous(cat(3, pascal(3)<3, pascal(3)>3))
%   isContiguous(cat(3, pascal(3)<3, pascal(3)>3), sqrt(2))
%   isContiguous(cat(3, pascal(3)<3, pascal(3)>3), sqrt(3))
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


if nargin < 2; thr = 1; end

[x,y,z] = ind2sub(size(volumetricRegion), find(volumetricRegion(:)));
v = [x,y,z];
d = pdist2(v,v); % faster than squareform(pdist(v))
d(1:length(d)+1:end) = Inf;
g = graph(d <= thr);
out = all(conncomp(g) == 1); % check there is only one component
% [dists, idx] = min(d);
% out = all(dists<=thr);

end