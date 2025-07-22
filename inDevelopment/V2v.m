function [v,d] = V2v(V, tform, isNiftiTform, mask)
%% V2v Volume to vertices, assumes that Volume should be 0-indexed
if nargin < 2 || isempty(tform);        tform        = eye(4);  end
if nargin < 3 || isempty(isNiftiTform); isNiftiTform = false;   end
if nargin < 4;                          mask         = [];      end
mask = processMask(V,mask); 
v = affineVerts(vol2xyz(V,mask)-1, tform, isNiftiTform); 
d = V(mask); 
end
