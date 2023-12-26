function Q = makeRandomRotationMatrixDirect(d, seed)

if nargin >= 2; rng(seed); end

A=[];
for j=1:d
    aa=randn(d,1);
    A(j,:) = aa/norm(aa);
end

[Q,R] = qr(A); 
Q = Q*diag(sign(diag(R)));%*S;

Q(:,1) = Q(:,1)*det(Q);

% while det(Q)<0
%     A(:,randi(d))=-A(:,randi(d));
%     [Q,R] = qr(A); 
% end


end