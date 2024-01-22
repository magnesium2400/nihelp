function [out, dists, idx] = isContiguous(volumetricRegion, thr)

if nargin < 2; thr = 1; end

[x,y,z] = ind2sub(size(volumetricRegion), find(volumetricRegion(:)));
v = [x,y,z];
d = pdist2(v,v); % faster than squareform(pdist(v))
d(1:length(d)+1:end) = Inf;
[dists, idx] = min(d);
out = all(dists<=thr);

end