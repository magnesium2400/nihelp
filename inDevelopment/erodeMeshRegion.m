function newRois = erodeMeshRegion(verts, faces, rois, regionToErode, numberOfErosions)

paren = @(a,b) a(b);
getNeighbors    = @(vert, faces)        setdiff(unique( getRowsContaining(faces, vert)' ),vert); %returns col vec
getNeighborRois = @(vert, faces, rois)  paren(rois(getNeighbors(vert, faces)), rois(getNeighbors(vert, faces)) ~= rois(vert));
% getNeighborRois = @(vert, faces, rois)  setdiff( rois(getNeighbors(vert, faces))  , rois(vert));

newRois = rois;

for n = 1:numberOfErosions

    roiFaces = newRois(faces);
    boundaryFaces = any(roiFaces==regionToErode,2) & ~all(roiFaces==regionToErode,2);
    boundaryVerts = intersect(faces(boundaryFaces,:), find(newRois==regionToErode));

    canditateRois = arrayfun( @(x) getNeighborRois(x,faces,newRois) , boundaryVerts, 'uni', 0);

    for ii = 1:length(boundaryVerts)

        newRois(boundaryVerts(ii)) = mode(canditateRois{ii});
        % if length(unique(canditateRois{ii})) == 1
        %     newRois(boundaryVerts(ii)) = canditateRois{ii}(1);
        %     continue;
        % end
        %
        % [~,~,modes] = mode(canditateRois{ii});
        % if length(modes{1}) == 1
        %     newRois(boundaryVerts(ii)) = modes{1};
        %     continue;
        % end



    end

end

end

