function out = triangulation2edges(faces)
%% TRIANGULATION2EDGES Mesh triangulation to edge list
out = [...
    reshape(faces           , [], 1), ...
    reshape(faces(:,[2 3 1]), [], 1)
    ]; 
end