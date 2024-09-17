---
layout: default
title: calc_eigenstrap
checksum: 04f60e2bfd920cee73cea618a576c5bd
parent: modes
---


 
# CALC_EIGENSTRAP Calculate eigenstrapped surrogate maps
 
# Syntax
```matlab
s = calc_eigenstrap(s, 'map', map);
s = calc_eigenstrap(s, 'mapName', mapName);
s = calc_eigenstrap(___, Name, Value);
[s, surrs, rots] = calc_eigenstrap(___);
```
 
# Description

`s = calc_eigenstrap(s, 'map', map);` calculates eigenstrapped surrogate null maps using the surface `s` and surface `map`.


`s = calc_eigenstrap(s, 'mapName', mapName);` calculates eigenstrapped surrogate null maps using the surface `s` and a map `mapName` that is already a field of the struct `s`.


`s = calc_eigenstrap(_, Name, Value);` specified additional properties using one or more name-value arguments. This may include the number of surrogates to generate, the method for reconstructing the map using the eigenmodes, or whether to resample the surrogates from the values in the original map.


`[s, surrs, rots] = calc_eigenstrap(_);` also returns the surrogate maps and the rotation matrices used to generate them.

 
# Examples

See `calc_eigenstrap_test.m` for examples.

 
# Input Arguments

`s - struct containing mesh with vertices and faces and/or pre-computed eigenvectors and eigenvalues (struct)` `s` should contain either: (i) fields `vertices` (a `V*3` matrix of vertex xyz coordinates) and 'faces' (an `F*3` or `F*4` matrix of triangles or tetrahedra); or (ii) fields `evecs` (a `V*n` matrix of eigenvectors) and `evals` (an `n*1` vector of eigenvalues). [If using the 'orthogonal' method, this must also contain a field 'mass' with the mass matrix].


`map - data map to use for eigenstrapping (V*1 vector)` This map must have one value for each vertex on the mesh.


`mapName - name of the map to use for eigenstrapping ('map' (default) | string scalar | char array` If `map` is not supplied, this should be the fieldname of a map that is already contained in the struct `s`.

 
## Name-value Arguments

`nSurrogates - number of surrogate maps to generate (1 (default) | positive integer scalar)`


`save - flag to save information contained in current call (true (default) | false)` If set to true, the following fields will be written to `s`: `mapName`, containing the map used to generate surrogates; `mapName`_surrs, containing the surrogates; `mapName`_rots, containing the rotation matrices; and `mapName`_info, containing information about the parameters used.


`seed - seed to use to set random stream ([] (default) | 'default' | nonnegative integer scalar)`


`overwriteModes - flag to overwrite the modes already calculated in s (false (default) | true)` If set to true, modes will be (re-)calculated, and the fields 'mass', 'stiffness', 'evecs', and 'evals' will be overwritten in `s`.


`addResiduals - flag to add residuals of map reconstruction to surrogate maps (false (default) | true)`


`resample - flag to resample values in surrogate map from original map (false (default) | true)`


`nModes - number of modes to use in eigenstrapping (6 (default) | positive integer scalar)`


`lump - flag to lump mass matrix (false (default) | true)`


`sigma - approximation of first eigenvalue (-0.01 (default) | scalar)`


`method - method to use for reconstruction of map ('orthogonal' (default) | 'matrix' | 'matrix_separate' | 'regression')`

 
# Output Arguments

`s - struct with eigenstrapped surrogates` However, if `save` is set to `false`, surrogates will not be added to `s` (and will only be output via the `surrs` argument).


`surrs - eigenstrappeed surrogates (nVerts * nSurrogates matrix)`


`rots - rotation matrices used to generate surrogates (nModes * nModes * nSurrogates matrix)`

 
# TODO
-  docs 
-  add support for multiple maps, perhaps using the same rotation matrices 
 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See Also

`calc_eigendecomposition`, `calc_eigenreconstruction`, `calc_mass_stiffness`, `calc_geometric_eigenmode`, `getEigengroupIdx`, `sorthogonal`, `meshVariogram`


Koussis et al (2024), *Generation of surrogate brain maps preserving spatial autocorrelation through random rotation of geometric eigenmodes*, 10.1101/2024.02.07.579070

