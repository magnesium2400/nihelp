---
layout: default
title: getAllEigengroupIdx
checksum: 0b6a35f460e917ce3012145a74f2187d
parent: modes
---


 
# GETALLEIGENGROUPIDX Return cell array of the indices making up each eigengroup in input

input: either (i) number of modes; or (ii) nVerts * nModes matrix (nModes is dimension 2) output: cell array of indices making up each group, with the last element truncated if the number of modes is not a perfect square NOTE: THE FIRST ELEMENT IS [1], NEXT IS [2 3 4] etc. i.e. this function is 1-indexed and includes the first (constant) mode

