function out = grad(verts, faces, data)

e1 = verts(faces(:,3), :) - verts(faces(:,2), :);
e2 = verts(faces(:,1), :) - verts(faces(:,3), :);
e3 = verts(faces(:,2), :) - verts(faces(:,1), :);

% used for weighted sum of edges
a = permute(data(faces),[1 3 2]);
b = cat(3,e1,e2,e3); 
c = a .* b; 
d = sum(c,3); % clear a b c

n = cross(e3, -e2, 2); % normals 
m = sum(n.^2,2); % clear n
out = ( e3.*dot(d,e2,2) - e2.*dot(e3,d,2) ) ./ m; % ./ division 1x for vector normalisation, 1x for area normalisation

% Note that the above calculation (using the vector triple product) is faster
% than the same calculation using explicit calls to `cross`: 
% out = cross(n, sum(c,3), 2) ./ sum(n.^2,2); 
end
