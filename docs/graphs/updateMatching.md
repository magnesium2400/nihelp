---
layout: default
title: updateMatching
checksum: 75add378653633767a9421f78bce83b3
parent: graphs
---


 
# UPDATEMATCHING Compute matching index by only making changes when edge added
 
# Syntax
```matlab
[~,m] = updateMatching(a)
[a,m,n,d] = updateMatching(a,m,n,d,ii,jj)
```
 
# Description

`[~,m] = updateMatching(a)` calculates the matching index for each pair of nodes in a network given by adjacency matrix `a`.


`[a,m,n,d] = updateMatching(a,m,n,d,ii,jj)` quickly calculates the matching index for each pair of nodes when the edge between node `ii` and node `jj` is added to the network given by adjacency matrix `a`. You should run `[a,m,n,d] = updateMatching(a);` to get the matrices `m`,`n` and `d` - which you can then provide as input into subsequent runs.

 
# Input Arguments
```matlab
`a - (original) adjacency matrix (square symmetric unweighted numeric matrix)`
```
```matlab
`m - (original) matching index (square symmetric numeric matrix)`
```
```matlab
`n - (original) numerator matrix (square symmetric non-negative integer matrix)`
`n(ii,jj)` contains the total number of edges from node `ii` and node `jj`
that connect to the common neighbors between the two nodes. This is equal to
twice the number of neighbors that the two nodes share.
```
```matlab
`d - (original) denominator matrix (square symmetric non-negative integer matrix)`
`d(ii,jj)` contains the total number of edges connected to node `ii` and node
`jj` (excluding any connection between them, if it exists, by convention).
```
```matlab
`ii - endpoint of new edge being added (positive integer)`
```
```matlab
`jj - endpoint of new edge being added (positive integer)`
```
 
# Examples
```matlab
[~,m] = updateMatching(+(gallery('toeppd', 10)<0))
W = zeros(500); [a,m,n,d] = updateMatching(W); [x,y] = find(~W); [x,y] = deal(x(x>y), y(x>y)); newEdges = randsample(length(x), 100); for ii = 1:length(newEdges); [a,m,n,d] = updateMatching( a,m,n,d,x(newEdges(ii)),y(newEdges(ii)) ); end
```
 
# Output Arguments
```matlab
`a - (new) adjacency matrix (square symmetric unweighted numeric matrix)`
```
```matlab
`m - (new) matching index (square symmetric numeric matrix)`
```
```matlab
`n - (new) numerator matrix (square symmetric non-negative integer matrix)`
```
```matlab
`d - (new) denominator matrix (square symmetric non-negative integer matrix)`
```
 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See Also

`matching_ind`, `matching_ind_und` (Rick Betzel, Brain Connectivity Toolbox) `matching` (Stuart J Oldham, FasterMatchingIndex)

