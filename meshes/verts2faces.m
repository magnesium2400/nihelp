function out = verts2faces(faces, vertData)
    out = mean(vertData(faces), 1);
end
