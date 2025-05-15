function D = meshExactGeodesicDistances(verts, faces, sources)

if ~exist('toolbox_fast_marching', 'dir')
    error('Requires Fast Marching with Planning Examples Toolbox from https://github.com/davizinho5/Fast_Marching_path_planning_examples'); 
end

if nargin > 3; error(['targets and radius not yet supported.\n' ...
        'See perform_fast_marching_mesh and perform_front_propagation_mesh.cpp \n' ...
        'documentation for more information. Note that targets will cause the ' ...
        'algorithm to terminate once any of the targets are reached']);
end

if nargin < 3 || isempty(sources) || strcmp(sources, 'all')
    sources = 1:height(verts); 
end


D = nan(height(verts), numel(sources)); 
for ii = 1:numel(sources)
    D(:,ii) = perform_fast_marching_mesh(verts', faces', sources(ii)); 
end


end
