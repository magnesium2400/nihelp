function out = calcVertexDist(verts, faces)
%% CALCVERTEXDIST average distance from vertex to each of its neighours

out = nan(length(verts), 1);

for ii = 1:length(verts) % loop over all vertices
    currentFaces = any(faces == ii, 2); % get all faces containing current vertex
    currentVerts = unique(faces(currentFaces, :)); % all the adjacent verts
    currentVerts(currentVerts==ii) = [];
    out(ii) = mean(pdist2(verts(ii, :), verts(currentVerts, :)));
end

end
