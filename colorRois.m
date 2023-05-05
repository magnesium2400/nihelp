function coloring = colorRois(faces, rois)
%COLORROIS Wrapper to get heuristic graph coloring using Johnson algorithm
%   Syntax
%   ---
%   c = colorRois(faces, rois)
%   
%   
%   Description
%   ---
%   c = colorRois(faces, rois) returns a graph labelling of the rois such that
%   no two adjacent rois share the same label (i.e. color).
%   
%   
%   Usage
%   ---
%   c = colorRois(lh_faces, lh_aparc);
%   colors = colorRois(lh_faces, lh_aparc);  figure; plotBrain(verts, faces, lh_aparc, colors, 'plotSurface', {'faces', lines(length(unique(colors))), 0, 1});
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
%   Ouput Arguments
%   ---
%   coloring - color allocations of each roi (vector)
%   R × 1 matrix, where each roi is labelled by a positive integer such that no
%   two adjacent rois share the same label (where R is the number of rois).
%   
%   
%   Authors
%   ---
%   Mehul Gajwani, Monash University, 2023

% TODO : consider using a stochastic definitive algorithm, rather than the
% heuristic that is currently used

coloring = GraphColoringJohnson(graph(generateAdjacencyMatrix(faces, rois)))+1;  

end