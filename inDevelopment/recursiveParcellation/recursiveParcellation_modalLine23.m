function out = recursiveParcellation_modalLine23(split, params, mask)


%% Prelims + get first 10 modes
assert(split == 2, 'split must be 2 when using modal line parcellation. Consider using modal range.');
if nargin < 3 || isempty(mask)
    mask = true(height(params.vertices), 1);
else
    mask = logical(mask);
end

[vertices, faces, ~, ~] = ...
    trimExcludedRois(params.vertices, params.faces, mask, 'removeUnconnected', false);

assert(height(vertices)==nnz(mask))
s = calc_geometric_eigenmode(struct('vertices', vertices, 'faces', faces), 10);


%% Find the mode most perpendicular to the second mode
g2 = grad(s.vertices, s.faces, s.evecs(:,2));

d = nan(height(s.faces), length(s.evals)-2); 
for ii = 3:length(s.evals)
    g = grad(s.vertices, s.faces, s.evecs(:,ii));
    d(:,ii-2) = dot(g, g2, 2);
end

[~,idx] = min(sum(abs(d)));
idx = [2, idx+2];
evecs = s.evecs(:,idx);


%% choose random weighting for the recombination (until one works without error)
if isfield(params, 'seed'); rng(params.seed); end

while true
    try
        t = rand(1)*2*pi;
        out = evecs * [cos(t);sin(t)];
        out = +(out>0);
        out = fixDanglingVertices(vertices, faces, out, 5);
        break;
    catch
    end
end


end

