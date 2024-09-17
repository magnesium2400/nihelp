function [s, surrs, rots] = calc_eigenstrap(s, varargin)
%% CALC_EIGENSTRAP Calculate eigenstrapped surrogate maps
%% Syntax
%  s = calc_eigenstrap(s, 'map', map); 
%  s = calc_eigenstrap(s, 'mapName', mapName); 
%  s = calc_eigenstrap(___, Name, Value); 
%  [s, surrs, rots] = calc_eigenstrap(___); 
%  
%  
%% Description
% `s = calc_eigenstrap(s, 'map', map);` calculates eigenstrapped surrogate null
% maps using the surface `s` and surface `map`. 
% 
% `s = calc_eigenstrap(s, 'mapName', mapName);` calculates eigenstrapped
% surrogate null maps using the surface `s` and a map `mapName` that is already
% a field of the struct `s`. 
% 
% `s = calc_eigenstrap(___, Name, Value);` specified additional properties using
% one or more name-value arguments. This may include the number of surrogates to
% generate, the method for reconstructing the map using the eigenmodes, or
% whether to resample the surrogates from the values in the original map.
% 
% `[s, surrs, rots] = calc_eigenstrap(___);` also returns the surrogate maps and
% the rotation matrices used to generate them. 
% 
% 
%% Examples
% See `calc_eigenstrap_test.m` for examples.   
% 
% 
%% Input Arguments
% `s - struct containing mesh with vertices and faces and/or pre-computed
% eigenvectors and eigenvalues (struct)` `s` should contain either: (i) fields
% `vertices` (a `V*3` matrix of vertex xyz coordinates) and 'faces' (an `F*3` or
% `F*4` matrix of triangles or tetrahedra); or (ii) fields `evecs` (a `V*n`
% matrix of eigenvectors) and `evals` (an `n*1` vector of eigenvalues). [If
% using the 'orthogonal' method, this must also contain a field 'mass' with the
% mass matrix]. 
% 
% `map - data map to use for eigenstrapping (V*1 vector)` This map must have one
% value for each vertex on the mesh. 
% 
% `mapName - name of the map to use for eigenstrapping ('map' (default) | string
% scalar | char array` If `map` is not supplied, this should be the fieldname of
% a map that is already contained in the struct `s`. 
% 
% 
%% %% Name-value Arguments
% `nSurrogates - number of surrogate maps to generate (1 (default) | positive
% integer scalar)`
%
% `save - flag to save information contained in current call (true (default) |
% false)` If set to true, the following fields will be written to `s`:
% `mapName`, containing the map used to generate surrogates; `mapName`_surrs,
% containing the surrogates; `mapName`_rots, containing the rotation matrices;
% and `mapName`_info, containing information about the parameters used. 
%
% `seed - seed to use to set random stream ([] (default) | 'default' |
% nonnegative integer scalar)`
% 
% `overwriteModes - flag to overwrite the modes already calculated in s (false
% (default) | true)` If set to true, modes will be (re-)calculated, and the
% fields 'mass', 'stiffness', 'evecs', and 'evals' will be overwritten in `s`. 
% 
% `addResiduals - flag to add residuals of map reconstruction to surrogate maps
% (false (default) | true)`
% 
% `resample - flag to resample values in surrogate map from original map (false
% (default) | true)`
% 
% `nModes - number of modes to use in eigenstrapping (6 (default) | positive
% integer scalar)`
% 
% `lump - flag to lump mass matrix (false (default) | true)`
% 
% `sigma - approximation of first eigenvalue (-0.01 (default) | scalar)`
% 
% `method - method to use for reconstruction of map ('orthogonal' (default) |
% 'matrix' | 'matrix_separate' | 'regression')`
% 
% 
%% Output Arguments
% `s - struct with eigenstrapped surrogates` However, if `save` is set to
% `false`, surrogates will not be added to `s` (and will only be output via the
% `surrs` argument). 
% 
% `surrs - eigenstrappeed surrogates (nVerts * nSurrogates matrix)`
% 
% `rots - rotation matrices used to generate surrogates (nModes * nModes *
% nSurrogates matrix)`
% 
% 
%% TODO
% * docs
% * add support for multiple maps, perhaps using the same rotation matrices
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 
%% See Also
% `calc_eigendecomposition`, `calc_eigenreconstruction`, `calc_mass_stiffness`, 
% `calc_geometric_eigenmode`, `getEigengroupIdx`, `sorthogonal`, `meshVariogram`
%
% Koussis et al (2024), _Generation of surrogate brain maps preserving spatial
% autocorrelation through random rotation of geometric eigenmodes_,
% 10.1101/2024.02.07.579070
%
%


%% Prelims
ip = inputParser;
ip.addParameter('map', []); 
ip.addParameter('mapName', 'map');  
ip.addParameter('nSurrogates', 1); 
ip.addParameter('save', true);
ip.addParameter('seed', []); 
ip.addParameter('overwriteModes', false);
ip.addParameter('addResiduals', false); 
ip.addParameter('resample', false);  

ip.addParameter('nModes', []); 
ip.addParameter('lump', false);
ip.addParameter('sigma', -0.01); 
ip.addParameter('method', 'orthogonal', @(x) isStringScalar(x) || ischar(x)); 

ip.parse(varargin{:}); 
ipr = ip.Results;


%% Prelims cont - check if modes and map are already contained in `s`
%%% Calculate modes if required
if ~isfield(s, 'evecs') || ~isfield(s, 'evals') || ipr.overwriteModes || ...
         (~isempty(ipr.nModes) && (ipr.nModes > numel(s.evals)))
    s = calc_geometric_eigenmode(s, ipr.nModes, ipr.sigma, logical(ipr.lump)); 
elseif isempty(ipr.nModes)
    ipr.nModes = numel(s.evals); 
end

%%% Find map
if ~isempty(ipr.map)
    map = ipr.map;
elseif isfield(s, ipr.mapName)
    map = s.(ipr.mapName);
else 
    error('Map not specified'); 
end


%% Eigenstrapping
%%% Calculate reconstruction and beta weights of map
[~,recon,beta] = calc_eigenreconstruction(map, s.evecs, ipr.method, ipr.nModes, s); 
errs = map - recon; 

%%% Calculate rotation matrices
%%%%% Probably could be sped up by doing group-wise multiplication instead of
%%%%% block diagonal multiplication
try rng(ipr.seed); catch; end
rots = zeros(ipr.nModes, ipr.nModes, ipr.nSurrogates); 
rots(1,1,:) = 1; 
for ii = 1:ipr.nSurrogates
    for jj = 2:ceil(sqrt(ipr.nModes))
        idx = getEigengroupIdx(jj, ipr.nModes); 
        rots(idx,idx,ii) = sorthogonal(numel(idx))'; 
    end
end

%%% Rotate on hypersphere
sqrtEvals = sqrt(s.evals(:))'; sqrtEvals(1) = 1; invsqrtEvals = 1./sqrtEvals; 
eigenRots = pagemtimes( s.evecs .* invsqrtEvals , rots ) .* sqrtEvals;
% eigenRots = pagemtimes( s.evecs * diag(invsqrtEvals) , rots);
% eigenRots = pagemtimes( eigenRots, diag(sqrtEvals) );

%%% Calculate new maps
surrs = nan(height(map), ipr.nSurrogates); 
for ii = 1:ipr.nSurrogates
    surrs(:,ii) = eigenRots(:,:,ii)*beta{1}; 

    if ipr.addResiduals
        surrs(:,ii) = surrs(:,ii) + errs(randperm(numel(errs)));
    end

    if ipr.resample
        surrs(:,ii) = scaffoldSort(map, surrs(:,ii));
    end
end


%% Add information to struct
if ipr.save
    f = @(x) sprintf("%s_%s", ipr.mapName, x);

    s.(ipr.mapName) = map;
    s.(f('surrs'))  = surrs;
    s.(f('rots'))   = rots;

    s.(f('info'))   = ipr;
    s.(f('info')).datetime = string(datetime);
end


end
