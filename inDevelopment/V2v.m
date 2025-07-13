function out = V2v(V, tform, isNiftiTform)
if nargin < 2 || isempty(tform);        tform        = eye(4); end
if nargin < 3 || isempty(isNiftiTform); isNiftiTform = false;  end
out = affineVerts(vol2xyz(V,logical(V))-1, tform, isNiftiTform); 
end
