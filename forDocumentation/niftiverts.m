function verts = niftiverts(filename)

V = niftiread(filename); 
nt = niftiinfo(filename).Transform.T; 
verts = affineVerts(vol2xyz(V,logical(V))-1, nt, 1); 

end
