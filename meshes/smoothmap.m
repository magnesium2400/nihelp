function out = smoothmap(verts, faces, nModes, seed)
%% SMOOTHMAP Generates a smooth scalar function on a surface using its eigenmodes
%% Examples
%   [v,f] = sphereMesh; c = smoothmap(v,f,20); 
%   [v,f] = sphereMesh; c = smoothmap(v,f,20); figure; patchvfc(v,f,c); 
%   [v,f] = sphereMesh(50); c = smoothmap(v,f,99,1); figure; patchvfc(v,f,c); 
%   [v,f] = torusMesh(50);  c = smoothmap(v,f,99,1); figure; patchvfc(v,f,c); 
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


s = calc_geometric_eigenmode(struct('vertices', verts, 'faces', faces), nModes); 

if nargin > 3 && ~isempty(seed); try rng(seed); catch; end; end

out = s.evecs * (s.evals .* randn(nModes,1)); 

end
