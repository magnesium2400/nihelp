function out = tril2vec(A,k)
if nargin < 2; k = 0; end
out = reshape(A(tril(true(size(A)), k)), [], 1);
end
