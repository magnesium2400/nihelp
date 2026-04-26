function out = dotw(A, B, w)
% dot product between corresponding columns (not pairwise)
out = dot(A, weights2spmat(w) * B, 1);
end
