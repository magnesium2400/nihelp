function [verts, faces] = permuteVerts(verts, faces, new, old)

idx = 1:height(verts); 
idx = renumber(idx, new, old); 
verts(idx,:) = verts; 

faces = renumber(faces, new, old); 

end