function out = sliceDim(V, d, n)
%% SLICEDIM extract the n-th slice from the d-th dimension of volume V
colons = repmat({':'}, 1, ndims(V));
colons{d} = n;
out = V(colons{:});
out = permute(out, [setdiff(1:ndims(V), d), d]);

end
