function [G, A] = generateGraph(faces, rois)


%% Prelims
roiIds = unique(nonzeros(rois));
nRois = length(roiIds);
A = zeros(nRois);

roiFaces = rois(faces); % matrix of the roi allocations for each face

%% 
% find the faces that have different roi allocations on their vertices
% with the non-zero rois excluded 
boundaryFaces = any(diff(roiFaces, 1, 2), 2) & all(roiFaces ~= 0, 2);

% for each pair of dimensions (1&2/1&3/2&3), get the rois on those faces and set
% the adjacency matrix 
for ii = 2:3
    for jj = 1:(ii-1)
        temp = sub2ind(size(A), ...
            roiFaces(boundaryFaces, ii), roiFaces(boundaryFaces, jj));
        A(temp) = 1;
    end
end

% diag to 0 and make graph
A = logical(A+A.');
A(1:(nRois+1):end) = 0;
G = graph(A);

end