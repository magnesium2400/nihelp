function O = makeRandomRotationMatrix3(d, seed)
if nargin>1; rng(seed); end

O = eye(d);

for ii = 1:d
    v = randn(ii, 1);
    vhat = v/norm(v);
    temp = H(d, vhat);
    O = temp*O;
end

end


function out = H(d, vhat)
uhat=vhat;
uhat(1) = uhat(1) + sign(vhat(1));
uhat = uhat/norm(uhat);
h = -sign(vhat(1)) * ( eye(length(vhat)) - 2*(uhat*uhat.') );
out = blkdiag(eye(d-length(vhat)), h);
end
