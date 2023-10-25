function [out, mask] = getHomotopicConnections(w)

sqform = false;
if size(w, 1) == 1 || size(w, 2) == 1
    w = squareform(w);
    sqform = true;
end

assert(issymmetric(w));
out = diag(w( (end/2+1):end, 1:end/2 ));

if nargout < 2; return; end

n = length(w);
mask = false(n);
mask( sub2ind([n n], (n/2+1):n, 1:n/2) ) = true;
if sqform; mask = squareform(mask); end

end
