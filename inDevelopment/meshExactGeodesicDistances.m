function D = meshExactGeodesicDistances(verts, faces, sources, targets)

%% Prelims
if ~exist('toolbox_fast_marching', 'dir')
    error(['Requires Fast Marching with Planning Examples Toolbox from ' ...
        'https://github.com/davizinho5/Fast_Marching_path_planning_examples']); 
end

if nargin < 3 || isempty(sources) || strcmp(sources, 'all')
    sources = 1:height(verts); 
end

if nargin < 4 || isempty(targets) || strcmp(targets, 'all')
    targets = 1:height(verts); 
end

if numel(sources)>12; warning("This algorithm is not parallelised " + ...
        "and is likely to be slow for a large number of sources. " + ...
        "Proceed with caution"); 
end


%% Calcs
D = nan(numel(sources), numel(targets)); 
for ii = 1:numel(sources)
    tmp = perform_fast_marching_mesh(verts', faces', sources(ii)); 
    D(ii,:) = tmp(targets)'; 
end


end
