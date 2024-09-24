---
layout: default
title: mapproject
checksum: 3ccabe31ae90a61715493fc705c89859
parent: maths
---


 
# MAPPROJECT Project from unit sphere to plane or plane to unit sphere
 
# Examples
```matlab
v=randn(1000,3); v=v./vecnorm(v,2,2); v2=mapproject(v,'eqaazim'); figure; scatter(v(:,1),v(:,2));
v=randn(1000,3); v=v./vecnorm(v,2,2); v2=mapproject(mapproject(v,'eqaazim'),'eqaazim'); assert(allclose(v,v2));
p=[sqrt(rand(1000,1))*2, rand(1000,1)*2*pi]; v=p(:,1).*[cos(p(:,2)),sin(p(:,2))]; v=mapproject(v,'eqaazim'); figure; scatter3(v(:,1),v(:,2),v(:,3),'.');
```
```matlab
[v,f]=sphereMesh; figure; nexttile; patchvfc(v,f); v2=mapproject(v,'eqacylin'); nexttile; patchvfc(v2,f);
v=randn(1000,3); v=v./vecnorm(v,2,2); for t=["eqaazim","cassini","eqdcylin","eqacylin"]; v2=mapproject(mapproject(v,t),t); assert(allclose(v,v2)); end
```
 
# TODO
-  docs 
 
# See also

`https://en.wikipedia.org/wiki/List_of_map_projections` `https://au.mathworks.com/help/map/summary-and-guide-to-projections.html`

 
# Authors

Mehul Gajwani, Monash University, 2024

