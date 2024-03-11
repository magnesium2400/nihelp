function out = verts2faces(faces, vertData)
    out = mean(vertData(faces), 2);
end
