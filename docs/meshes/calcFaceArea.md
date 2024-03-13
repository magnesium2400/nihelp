---
layout: default
title: calcFaceArea
checksum: 7ccd3da44cc80af1780b8b922e0a04ac
parent: meshes
---


 
# CALCFACEAREA gets area of each face in a surface patch object
 
# Examples
```matlab
[x,y]=meshgrid(1:10); z=repmat(1:10,10,1)*sqrt(3); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
[x,y]=meshgrid((1:10).^2); z=x+y; v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
[x,y]=meshgrid(1:20); z=peaks(20); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
if ~isempty(which('getFaceArea')); [x,y]=meshgrid(1:20); z=peaks(20); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); b=arrayfun(@(ii)getFaceArea(struct('vertices',v),f,ii),1:length(f)).'; figure; scatter(a,b); title(string(all(isclose(a,b)))); end
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

