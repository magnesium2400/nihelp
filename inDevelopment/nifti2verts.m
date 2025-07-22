function [v,d,V,I] = nifti2verts(filename, mask)
%% nifti2verts NIfTI to vertices in native space, accordint to Transform.T matrix
if nargin<2; mask = []; end
V = niftiread(filename);
I = niftiinfo(filename);
[v,d] = V2v(V, I.Transform.T, 1, mask); 
% v = affineVerts(vol2xyz(V,logical(V))-1, ni.Transform.T, 1); % shift by 1 as niftis are 0-indexed
end
