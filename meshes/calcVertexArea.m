function out = calcVertexArea(verts, faces)
%% CALCVERTEXAREA distribute face area to the surrounding vertices
%% Examples
%   [x,y]=meshgrid(1:10); z=zeros(size(x)); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcVertexArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
%   [x,y]=meshgrid((1:10).^2); z=x+y; v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcVertexArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', a);
%   [x,y]=meshgrid(1:20); z=peaks(20); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcVertexArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', a);
%   [v,f] = sphereMesh; a = calcVertexArea(v,f); figure; patch('Vertices',v,'Faces',f,'FaceColor','interp','FaceVertexCData',a); colorbar;  
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


fa = calcFaceArea(verts, faces);
out = arrayfun( @(ii) sum(fa(any(faces==ii,2))) , ...
    (1:max(faces, [], "all")).' ) / 3;
end

