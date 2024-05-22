---
layout: default
title: isElementsEqual
checksum: 1895078b2224b10f493385bb0eaa15dc
parent: meshes
---


 
# ISELEMENTSEQUAL Compare if faces/cells/cliques in a (triangular/tetrahedral) mesh are equal
 
# Examples
```matlab
[x,y]=meshgrid(1:10); d=delaunay(x(:),y(:)); isElementsEqual(d,flipud(d))
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

