---
layout: default
title: sampleConvexPolygon
checksum: d26df2f87322a7252b093adcc9a725ce
parent: maths
---


 
# SAMPLECONVEXPOLYGON Sample points inside convex polygon with ordered vertices
 
# Examples
```matlab
p = sampleConvexPolygon([0 0; -1 0; 0 1; 1 1; 1 0], 100);
v = [0 0; -1 0; 0 1; 1 1; 1 0]; p = sampleConvexPolygon(v, 10000); figure; scatter(v(:,1),v(:,2),'filled'); hold on; scatter(p(:,1),p(:,2),'.');
rng(2); t = sort(rand(20,1)*2*pi); v = [cos(t),sin(t)]; p = sampleConvexPolygon(v, 10000); figure; scatter(v(:,1),v(:,2),'filled'); hold on; scatter(p(:,1),p(:,2),'.');
```
 
# See Also

`https://blogs.sas.com/content/iml/2020/10/19/random-points-in-triangle.html`

 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

