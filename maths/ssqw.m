function out = ssqw(A,w)
% energy of each column
out = dot(A, weights2spmat(w) * A, 1);
end
