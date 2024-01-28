---
layout: default
title: vol2verts
parent: inDevelopment
---


# VOL2VERTS Finds center (mean) of each ROI in a volumetric parcellation
    
    
# Contents
   - Input Arguments
   - Output Arguments
   
# Input Arguments

```plaintext
V_rois - data to be parcellated (3 dimensional matrix)
3D matrix where the values at each point are the ROI ID of the voxel at
that point. Use 0 to indicate voxels to be excluded.
```


```plaintext
zeroMidline - flag for setting x-coordinates to be centred at 0 (false (default) | true)
```

    
# Output Arguments

```plaintext
verts - ROI centers (three column matrix)
```


```plaintext
W - adjacency matrix of connections between ROIs
W_{ij} is the number of vertices in region j that are adjacent to a
vertex in region j
```

    

