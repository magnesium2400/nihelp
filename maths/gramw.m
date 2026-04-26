function out = gramw(A, B, w)
% dot product between all columns
out = A' * (weights2spmat(w) * B); 
end
