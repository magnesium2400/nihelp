function N = vecnormw(A, w, p)
% Calculates the area-weighted L^p norm of spatial maps.
% u: (n_vertices x n_maps)
% w: (n_vertices x 1) OR sparse (n_vertices x n_vertices)
% p: Order of the norm (1, 2, inf, etc.)


if nargin<3 || isempty(p) || p==2 % Exact (well defined)
    N = sqrt(ssqw(A,w));

elseif p == Inf % Exact (ignores the mass matrix)
    N = max(abs(A), [], 1);

else % Approximate by lumping
    w = weights2spmat(w, height(A)); 
    N = sum(sum(w, 2) .* (abs(A).^p), 1) .^ (1/p);
end

end
