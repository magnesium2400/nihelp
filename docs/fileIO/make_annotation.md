---
layout: default
title: make_annotation
checksum: 1ca3c68b70c22d7e93c4981cfb723404
parent: fileIO
---


 
# Examples
```matlab
[vertices, label, ct] = make_annotation(randi(10,100,1));
[vertices, label, ct] = make_annotation(randi(10,100,1)-1);
[vertices, label, ct] = make_annotation(randi(10,100,1), 'cmap', @(x) jet(x)*255);
[vertices, label, ct] = make_annotation(randi(10,100,1), 'orig_tab', 'cool_rois');
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

