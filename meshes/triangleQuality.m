function out = triangleQuality(verts, faces)
%% TRIANGLEQUALITY Closeness to equilaterality as defined by LaPy
%% Examples
%   rng(1); v=rand(400,2); f=delaunay(v); v(:,3)=1; q=triangleQuality(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceVertexCData', q, 'FaceColor', 'flat'); colorbar;
%   [v,f]=squareMesh3(20); q=triangleQuality(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceVertexCData', q, 'FaceColor', 'flat'); colorbar;
%   [v,f]=squareMesh3(20); v(:,1)=v(:,1)+kron(ones(20,1)/2,(0:19)'); v(:,2)=v(:,2)*sqrt(3)/2; q=triangleQuality(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceVertexCData', q, 'FaceColor', 'flat'); colorbar;
%   [v,f]=squareMesh3(20,1); q=triangleQuality(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceVertexCData', q, 'FaceColor', 'flat'); colorbar;
%   
%   


faceAreas = calcFaceArea(verts, faces);

edges = [faces(:), reshape(faces(:, [2 3 1]), [], 1)];
vertsReshaped = reshape(verts(edges,:), [size(edges), width(verts)]);
edgeLengths = reshape(vecnorm( diff(vertsReshaped,[],2),2,3), [], 3); 

out = 4*sqrt(3)*faceAreas./sum(edgeLengths.^2,2);

end

