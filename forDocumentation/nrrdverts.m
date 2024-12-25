function verts = nrrdverts(filename)

V = nrrdread(filename); 
nt = nrrdinfo(filename).SpatialMapping.A; 
verts = affineVerts(vol2xyz(V,logical(V)), nt, 1); 

end
