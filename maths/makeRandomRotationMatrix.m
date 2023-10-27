function Q = makeRandomRotationMatrix(d, seed)
%% makeRandomRotationMatrix Makes d-dimdensional rotation matrix
%% See also
% https://arxiv.org/pdf/math-ph/0609050.pdf (Mezzadri 2006)
% https://en.wikipedia.org/wiki/Orthogonal_matrix#Randomization
% https://stats.stackexchange.com/questions/143903/how-to-generate-uniformly-random-orthogonal-matrices-of-positive-determinant

if nargin >= 2; rng(seed); end

A = randn(d);

% QR decomposition of normally iid matrix s.t. diag terms of R are positive
[Q,R] = qr(A); 
S = diag(sign(diag(R))); % A = (Q*S)*(S*R) and S*R has all pos terms on diagonal
Q = Q*S;

Q(:,1) = Q(:,1)*det(Q); % fix determinant (to prevent flipping)
assert(isclose(det(Q), 1));

end
