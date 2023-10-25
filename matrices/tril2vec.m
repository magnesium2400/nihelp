function out = tril2vec(A,k)
if nargin < 2; k = 0; end
temp = A(tril(true(size(A)), k));
out = temp(:);
end
