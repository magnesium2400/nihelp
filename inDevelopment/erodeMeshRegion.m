function newRois = erodeMeshRegion(verts, faces, rois, regionToErode, numberOfErosions)

A = logical(triangulation2adjacency(faces)); 
getNeighborRois = @(vert, faces, rois) rois(A(:,vert) & rois~=regionToErode); 

newRois = rois;
for n = 1:numberOfErosions

    % Find boundary vertices for current iteration
    roiFaces = newRois(faces);
    boundaryFaces = any(roiFaces==regionToErode,2) & ~all(roiFaces==regionToErode,2);
    boundaryVerts = intersect(faces(boundaryFaces,:), find(newRois==regionToErode));

    % Find ROIs of its neighbors (not in current region)
    canditateRois = arrayfun( @(x) getNeighborRois(x,faces,newRois) , boundaryVerts, 'uni', 0);

    % Update to most common neighbour
    newRois(boundaryVerts) = cellfun(@mode, canditateRois); 

end

end

