---
layout: default
title: splitapply0
checksum: ba803a4f8043db03ed5c7d7075022223
parent: sugar
---


 
# SPLITAPPLY0 Uses splitapply even if groups are indexed 0 or are absent
 
# Examples
```matlab
splitapply0(@(x) x, (1:3), (1:3))
splitapply0(@(x) x, (1:3), (1:3).^2)
splitapply0(@(x) x, (1:4), (0:3))
splitapply0(@(x) x, (1:3), (1:3), 6)
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

