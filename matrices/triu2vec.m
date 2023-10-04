function out = triu2vec(A,k)
if nargin < 2; k = 0; end
temp = A(triu(true(size(A)), k));
out = temp(:);
end
