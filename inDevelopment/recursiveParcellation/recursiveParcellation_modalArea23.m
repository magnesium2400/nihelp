function out = recursiveParcellation_modalArea23(split, params, mask)

if nargin < 3 || isempty(mask)
    mask = true(height(params.vertices), 1);
else
    mask = logical(mask);
end

[vertices, faces, ~, ~] = ...
    trimExcludedRois(params.vertices, params.faces, mask, 'removeUnconnected', false);
assert(height(vertices)==nnz(mask))
s = calc_geometric_eigenmode(struct('vertices', vertices, 'faces', faces), 10);
vertexAreas = params.vertexAreas(mask);


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
    t = rand(1)*2*pi;
    scores = evecs * [cos(t);sin(t)];
    [scoresOrdered,idx] = sort(scores, 'ascend');
    areasOrdered = cumsum(vertexAreas(idx));

    tmp = interp1(areasOrdered, scoresOrdered, areasOrdered(end) * (1:split-1)/split);
    thr = [scoresOrdered(1), tmp, scoresOrdered(end)];
    [~,~,bin] = histcounts(scores, thr);
    out = bin - 1;

    [out, rad] = fixDanglingVertices(vertices, faces, out, 5);
    if ~isinf(rad); break; end
end


end

