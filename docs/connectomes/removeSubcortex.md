---
layout: default
title: removeSubcortex
checksum: 6d099c3789465acea4bf02de3b9e3c88
parent: connectomes
---


 
# REMOVESUBCORTEX removes subcortex with MANY implicit assumptions
 
# Usage Notes

SPECIFY TOTAL NUMBER OF DATA POINTS IN MATRIX (***NOT*** NUMBER IN ONE HEMISPHERE)

```matlab
if inp == 68*68, assume Desikan Killiany and do nothing
if inp == 82*82, assume Desikan Killiany and remove 35-42 and 75-82
if inp == 200*200, assume Schaefer and do nothing
if inp == 220*220, assume Schaefer and remove 101-110 and 211-220
if inp == 360*360, assume Glasser and do nothing
if inp == 380*380, assume Glasser and remove 181-190 and 351-360
if inp == 500*500, assume Schaefer and do nothing
if inp == 520*520, assume Schaefer and remove 251-260 and 511-520
```
 
# Authors

Mehul Gajwani, Monash University, 2024

 
# ENDPUBLISH
