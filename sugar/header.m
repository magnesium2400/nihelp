function out = header(A,k)
if nargin < 2; k = 8; end
try out = head(A,k);
catch; out = A(1:min(k,size(A,1)),:); end
end