---
layout: default
title: isUnemptyField
checksum: 41c0eea3c6413c466352e96e3186d388
parent: assorted
---


 
# ISUNEMPTYFIELD returns true iff field is present and not empty
 
# Examples
```matlab
isUnemptyField(struct('a', [], 'b', 2), 'a')
isUnemptyField(struct('a', 11, 'b', 2), 'a')
isUnemptyField(struct('a', 11, 'b', 2), 'c')
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

