---
layout: default
title: calcFaceArea
checksum: 19f8ed7416c9322a79ca2bb3a499348e
parent: meshes
---


 
# CALCFACEAREA gets area of each face in a surface patch object
 
# Examples
```matlab
rng(10); v=rand(100,2); f=delaunay(v(:,1),v(:,2)); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
[x,y]=meshgrid(1:10); v=[x(:),y(:)]; f=delaunay(v(:,1),v(:,2)); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
[x,y]=meshgrid(1:10); z=repmat(1:10,10,1)*sqrt(3); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
[x,y]=meshgrid((1:10).^2); z=x+y; v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
[x,y]=meshgrid(1:20); z=peaks(20); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
if ~isempty(which('getFaceArea')); [x,y]=meshgrid(1:20); z=peaks(20); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); b=arrayfun(@(ii)getFaceArea(struct('vertices',v),f,ii),1:length(f)).'; figure; scatter(a,b); title(string(all(isclose(a,b)))); end
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

