function [edgeMean, edgeLengths, uniqueEdges] = calcEdgeLength(vertices, faces)
%% matches wb_command

%% Get unique edges
e = [faces(:,[1 2]); faces(:,[2 3]); faces(:,[3 1])];
e = sort(e, 2);
uniqueEdges = unique(e, 'rows');

%% Edge length and mean over all edges
p1 = vertices(uniqueEdges(:,1), :);
p2 = vertices(uniqueEdges(:,2), :);

edgeLengths = vecnorm(p1-p2,2,2);
edgeMean = mean(edgeLengths);

end
