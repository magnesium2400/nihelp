---
layout: default
title: faces2verts
checksum: 5b3415cb798ce80f0af323a3f4664813
parent: meshes
---


 
# FACES2VERTS Averages data from each face over each of its vertices
 
# Usage Notes

Consider the mesh given by the below:

```matlab
    1 ----- 2
   / \ 600 / \
  /   \   /   \
 / 300 \ / 900 \
3 ----- 4 ----- 5
```

The IDs of each vertex and the data at each face are shown (this is the same example as in the first example below). There are two ways to interpolate the data from faces to vertices: 1. Each face distributes 1/3 of its value to each of its vertices (this preserves the total sum across the mesh); 2. Each vertex is the average of the data on its faces (this could also be a weighted average e.g. weighted by area of each face).


This function implements the first method.

 
# Examples
```matlab
faces2verts([1 3 4; 1 4 2; 2 4 5], [300;600;900])
assert(isequal(faces2verts([1 3 4; 1 4 2; 2 4 5], [300;600;900]), [300;500;100;600;300]))
faces = [1 2 3; 2 3 4; 3 4 6]; faceData = 1:3; faces2verts(faces, faceData)
faces = [1 2 3; 2 3 4; 3 4 6]; faceData = 1:3; faces2verts(faces, faceData, 7)
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

