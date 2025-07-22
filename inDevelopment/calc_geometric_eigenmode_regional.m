function [s,V,D,M,S] = calc_geometric_eigenmode_regional(s, parc, k, sigma, lump)

V = nan(height(s.vertices), k); 
D = nan(k, max(parc));
M = sparse(height(s.vertices));  
S = sparse(height(s.vertices));  

for ii = 1:max(parc)
    [v,f,~,mask] = trimExcludedRois(s.vertices, s.faces, parc==ii, ...
        'removeUnconnected', true, 'overrideAssertions', true); 
    surf = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), k, sigma, lump); 

    w = min(k, nnz(mask));  % in case number of verts is less than nModes
    V(mask,1:w) = surf.evecs; 
    D(1:w,ii) = surf.evals; 
    % try making this faster by saving the edges and values here
    % and saving as sparse matrix at the end
    M(mask, mask) = surf.mass; 
    S(mask, mask) = surf.stiffness; 
end

s.mass = M; 
s.stiffness = S; 
s.evecs = V; 
s.evals = D; 
