function out = div(verts, faces, data)

% Edges and areas
e1 = verts(faces(:,3), :) - verts(faces(:,2), :);
e2 = verts(faces(:,1), :) - verts(faces(:,3), :);
e3 = verts(faces(:,2), :) - verts(faces(:,1), :);
ln = sqrt(sum(cross(e3, -e2, 2).^2, 2)); % 2*area

% Weighted edges
c1 = dot(e3, -e2, 2) .* e1 .* data ./ ln;
c2 = dot(e1, -e3, 2) .* e2 .* data ./ ln;
c3 = dot(e2, -e1, 2) .* e3 .* data ./ ln; 

% Contribution per triangle corner & total contribution
c = sum([c3;c1;c2]-[c2;c3;c1],2);
out = 0.5 * accumarray(faces(:), c, [height(verts), 1], @sum, 0);

end
