function out = faces2verts(faces, faceData)
    out = arrayfun( @(ii) mean(faceData(any(faces==ii,2))) , ...
        (1:max(faces, [], "all")).' );
end