function out = faces2edgelist(faces)
out = [ faces(:) , reshape( faces(:,[2 3 1]),[],1 ) ];
end