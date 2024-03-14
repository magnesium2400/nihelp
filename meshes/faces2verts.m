function out = faces2verts(faces, faceData)
%% FACES2VERTS Averages data from each face to each of its vertices
%% Examples
%   faces = [1 2 3; 2 3 4; 3 4 6]; faceData = 1:3; faces2verts(faces, faceData)
%
%
%% TODO
% * docs
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%


out = arrayfun( @(ii) mean(faceData(any(faces==ii,2))) , ...
    (1:max(faces, [], "all")).' );
end