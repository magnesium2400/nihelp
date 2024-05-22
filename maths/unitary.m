function Q = unitary(n, seed)
%% UNITARY Generates random unitary matrix
% https://nhigham.com/2020/04/22/what-is-a-random-orthogonal-matrix/
if nargin > 1 && ~isempty(seed); rng(seed); end
[Q, R] = qr(complex(randn(n), randn(n))); 
Q = Q*diag(sign(diag(R))); % in MATLAB, R has real entries on diagonal
end
