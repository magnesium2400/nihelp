---
layout: default
title: annotation2rois
checksum: cec7db943a426c7e1272e2b94fea4cab
parent: fileIO
---


 
# ANNOTATION2ROIS Converts a freesurfer '.annot' file to vector of ROI allocations (parcellation)
 
# Usage Notes

`out` indexes parcels based on the raw data from the annot file. Therefore, values of 0 correspond to missing values in the colortable (and values of 1 probably to masked areas e.g. medial wall). You probably want to use `out-1` as the actual parcellation vector.

 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

