function A = generateAdjacencyMatrix(faces, rois)
%GENERATEADJACENCYMATRIX Returns adjacency matrix from face and ROI allocations
%   Syntax
%   ---
%   A = generateAdjacencyMatrix(faces, rois)
%   
%   
%   Description
%   ---
%   A = generateAdjacencyMatrix(faces, rois) generates a binarized adjacency
%   matrix, where each element A_{ij} is 1 if there are any faces that span
%   region i and region j, and 0 otherwise
%   
%   
%   Examples
%   ---
%   A = generateAdjacencyMatrix(lh_faces, lh_aparc);
%   colors = GraphColoringJohnson(graph(generateAdjacencyMatrix(faces, lh_aparc)));  figure; plotBrain(verts, faces, lh_aparc, colors+1, 'plotSurface', {'faces', lines(length(unique(colors))), 0, 1});
%   
%   
%   Input Arguments
%   ---
%   faces - face allocations (matrix)
%   F × 3 matrix, where each row is the vertex IDs that make up each face (F is
%   the number of faces).
%
%   rois - parcellation aka ROI allocation (vector)
%   V × 1 matrix, where each element is the ROI that each vertex is allocated
%   to (V is the number of vertcies). 
%   
%   
%   Output Arguments
%   ---
%   A - adjacency matrix (matrix)
%   nRois × nRois binarized adjacency matrix, where each element A_{ij} is 1 if
%   there are any faces that span region i and region j, and 0 otherwise
%   
%   
%   Authors
%   ---
%   Mehul Gajwani, Monash University, 2023

% TODO : consider using SPARSE and SPFUN operators as described here https://stackoverflow.com/questions/28455189/matlab-adjacency-matrix-from-patch-object

%% Prelims
ip = inputParser;
addRequired(ip, 'faces');
addRequired(ip, 'rois');
addParameter(ip, 'overrideAssertions', false);

parse(ip, faces, rois);
faces = ip.Results.faces; 
rois = ip.Results.rois;


%% Assertions
if ~ip.Results.overrideAssertions
    assert(max(faces(:)) == size(rois, 1), ...
        'faces should use all the vertices');
    assert(size(faces, 2) == 3, ...
        'each face should have three vertices');
end


%% Computations
% setup
A = zeros(max(rois));
roiFaces = rois(faces); % matrix of the roi allocations for each face

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
A = +logical(A+A.');
A(1:(size(A,1)+1):end) = 0;

end