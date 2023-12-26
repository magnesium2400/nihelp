function Q = makeRandomRotationMatrix4(d, seed)

if nargin >= 2; rng(seed); end

A = randn(d,d);
        
% QR decomposition of normally iid matrix s.t. diag terms of R are positive (see Mezzadri 2007)
Q = qr(A);
Q = Q * diag(exp(1j * 2 * pi * rand(d,1)));

end




