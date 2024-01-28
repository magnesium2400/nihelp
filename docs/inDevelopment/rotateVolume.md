---
layout: default
title: rotateVolume
parent: inDevelopment
---


# ROTATEVOLUME Rotate 3-D volume in anatomical space
    
    
# Contents
   - Syntax
   - Description
   - Examples
   - Input Arguments
   - Output Arguments
   - See also
   - Authors
   
# Syntax

```plaintext
V = rotateVolume(V, srcOrientation, tgtOrientation)
```

    
# Description

`V = rotateVolume(V, srcOrientation, tgtOrientation)` rotates the volume V from the space srcOrientation to the space tgtOrientation.
   
# Examples

```plaintext
D = squeeze(load('mri').D); E = rotateVolume(D, 'prs', 'ras');
V = (1:10).'+(1:5)+permute(1:20,[1,3,2])-2; W = rotateVolume(V, 'als', 'pir');
D = squeeze(load('mri').D); E = rotateVolume(D, 'prs', 'ras'); figure; nexttile; plotVolume(D); nexttile; plotVolume(E);
D = (loadmri+(1:128).').*logical(loadmri); figure; nexttile; plotVolume(D); nexttile; plotVolume(rotateVolume(D, 'ras', 'ipl'));
```

# Input Arguments

```plaintext
V - Volume to be rotated (3-D array)
```


```plaintext
srcOrientation - Direction of positive x,y,z coordinates in original space (string scalar | character vector)
A string or character vector with three letters, where each letter represents
the direction of the positive x/y/z axis respectively. Use the letters
p,a,i,s,r,l to denote posterior, anterior, inferior, superior, right, and
left. For example, the data given by `squeeze(load('mri').D)` would have
srcOrientation 'prs'; radiological and neurological volumes would have
srcOrientation 'las' and 'ras'.
```


```plaintext
tgtOrientation - Direction of positive x,y,z coordinates in target space (string scalar | character vector)
```

    
# Output Arguments

```plaintext
V - Rotated volume (3-D array)
```

    
# See also

```plaintext
PERMUTE, FLIP, PLOTVOLUME, VOLSHOW
Imaging conventions: https://nipy.org/nibabel/neuro_radio_conventions.html
```

    
# Authors

Mehul Gajwani, Monash University, 2024
   

