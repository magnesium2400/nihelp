function out = smoothmap(verts, faces, nModes, seed)

s = calc_geometric_eigenmode(struct('vertices', verts, 'faces', faces), nModes); 

if nargin > 3 && ~isempty(seed); try rng(seed); catch; end; end

out = s.evecs * (s.evals .* randn(nModes,1)); 

end
