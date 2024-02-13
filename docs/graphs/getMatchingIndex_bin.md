---
layout: default
title: getMatchingIndex_bin
checksum: 75000976a310ffc8ba973b7ef29b2064
parent: graphs
---


 
# GETMATCHINGINDEX_BIN Get matching index of binary undirected graph
 
# Examples
```matlab
getMatchingIndex_bin((pascal(5)>1).*~eye(5))
```
 
# Input Arguments

`A - adjacency matrix (square symmetric matrix)`

 
# Output Arguments

`mi - matching index` Element-wise division of `num` and `denom`, with diagonal elements set to 0.


`num - two step connections`


`denom - node degrees excluding self connections`

 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

