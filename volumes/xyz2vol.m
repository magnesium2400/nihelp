function V = xyz2vol(xyz, data, fillVal, sz)
%% XYZ2VOL Converts xyz volumetric coordinates to 3-D volume
%% Examples
%   xyz = [1 1 1; 1 1 2; 1 2 1; 2 1 1]; V = xyz2vol(xyz); 
%   xyz = table2array(combinations(1:3,1:3,1:3)); V = xyz2vol(xyz); 
%   xyz = table2array(combinations(2:3,2:3,2:3)); V = xyz2vol(xyz,1:8,0,[4 4 4]); 
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



if any(xyz<1, 'all'); warning('Nonpositive entries, reindexing verts'); xyz = xyz-min(xyz)+1; end
if nargin < 2 || isempty(data);    data = true;    end
if nargin < 3 || isempty(fillVal); fillVal = nan;  end
if nargin < 4 || isempty(sz);      sz = max(xyz);  end

V = ones(sz).*fillVal; 
V(sub2ind(sz,xyz(:,1),xyz(:,2),xyz(:,3))) = data; 

end
