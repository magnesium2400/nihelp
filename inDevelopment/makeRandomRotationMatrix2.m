function Q = makeRandomRotationMatrix2(d, seed)
%% makeRandomRotationMatrix Makes uniform random d-dimdensional rotation matrix
%% See also
% https://arxiv.org/pdf/math-ph/0609050.pdf (Mezzadri 2006)
% https://en.wikipedia.org/wiki/Orthogonal_matrix#Randomization
% https://stats.stackexchange.com/questions/143903/how-to-generate-uniformly-random-orthogonal-matrices-of-positive-determinant

if nargin >= 2; rng(seed); end

A = 1/sqrt(2)*(randn(d)+1j*rand(d));

% QR decomposition of normally iid matrix s.t. diag terms of R are positive (see Mezzadri 2006)
[Q,R] = qr(A); 
S = (diag(R)./abs(diag(R))).*eye(d); % A = (Q*S)*(S*R) and S*R has all pos terms on diagonal
Q = Q*S;

% Q(:,1) = Q(:,1)*det(Q); % fix determinant in case it is -1 (to prevent flipping)
% assert( abs(det(Q) - 1) < 1e-4 );
% % assert(isclose(det(Q), 1));

end
