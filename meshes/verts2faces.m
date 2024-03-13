function out = verts2faces(faces, vertData)
%% VERTS2FACES Averages data from each vertex to each of its adjacent faces
%% Examples
%   faces = [1 2 3; 2 3 4; 3 4 6]; vertData = 1:6; verts2faces(faces, vertData)
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


out = mean(vertData(faces), 2);
end
