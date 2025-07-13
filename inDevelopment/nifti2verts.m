function [v,d,V,ni] = nifti2verts(filename)
V = niftiread(filename);
d = nonzeros(V); 
ni = niftiinfo(filename);
v = V2v(V,ni.Transform.T,1); 
% v = affineVerts(vol2xyz(V,logical(V))-1, ni.Transform.T, 1); % shift by 1 as niftis are 0-indexed
end
