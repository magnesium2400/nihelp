function b = mldividew(A, B, w)
% Use method of normal equations to give area-weighted least squares error
% See https://en.wikipedia.org/wiki/Weighted_least_squares#Motivation
w = weights2spmat(w);
b = (A'*w*A) \ (A'*w*B);
end
