function Q = makeRandomRotationMatrix(d, seed)

if nargin >= 2; rng(seed); end

R = -1;
while ~all(diag(R) > 0)
    [Q,R] = qr(randn(d));
end
Q(:,1) = Q(:,1)*det(Q);
assert(isclose(det(Q), 1))

end
