function Q = orthogonal(n, seed)
%% ORTHOGONAL Generates random orthogonal matrix
% https://nhigham.com/2020/04/22/what-is-a-random-orthogonal-matrix/
if nargin > 1 && ~isempty(seed); rng(seed); end
[Q, R] = qr(randn(n)); 
Q = Q*diag(sign(diag(R)));
end
