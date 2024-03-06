function out = triu2vec(A,k)
if nargin < 2; k = 0; end
out = reshape(A(triu(true(size(A)), k)), [], 1);
end
