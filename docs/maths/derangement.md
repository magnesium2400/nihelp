---
layout: default
title: derangement
checksum: 3e4cf42977842c76668fe00343595b73
parent: maths
---


 
# DERANGEMENT Returns a permutation where no element is in original position
 
# Examples
```matlab
derangement(10)
derangement(10,10)
out = cell2mat(arrayfun(@(x) derangement(4,x), (1:1000)', 'Uni', 0)); [C,~,ic] = unique(out, 'rows'); figure; histogram(ic, (0:height(C))+0.5);
```
 
# TODO
-  docs 
 
# See Also

Martínez, Conrado, Alois Panholzer, and Helmut Prodinger. "Generating Random Derangements." ANALCO. 2008

 
# Authors

Mehul Gajwani, Monash University, 2024

