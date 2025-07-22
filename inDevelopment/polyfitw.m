function [p,S,mu] = polyfitw(x,y,n,w)
%POLYFIT Fit polynomial to data.
%   P = POLYFIT(X,Y,N) finds the coefficients of a polynomial P(X) of
%   degree N that fits the data Y best in a least-squares sense. P is a
%   row vector of length N+1 containing the polynomial coefficients in
%   descending powers, P(1)*X^N + P(2)*X^(N-1) +...+ P(N)*X + P(N+1).
%
%   [P,S] = POLYFIT(X,Y,N) returns the polynomial coefficients P and a
%   structure S for use with POLYVAL to obtain error estimates for
%   predictions.  S contains these fields:
%
%         R  -  Triangular R factor (possibly permuted) from a QR
%               decomposition of the Vandermonde matrix of X
%        df  -  Degrees of freedom
%     normr  -  Norm of the residuals
%
%   If the data Y are random, an estimate of the covariance matrix of P is
%   (Rinv*Rinv')*normr^2/df, where Rinv is the inverse of R.
%
%   [P,S,MU] = POLYFIT(X,Y,N) finds the coefficients of a polynomial in
%   XHAT = (X-MU(1))/MU(2) where MU(1) = MEAN(X) and MU(2) = STD(X). This
%   centering and scaling transformation improves the numerical properties
%   of both the polynomial and the fitting algorithm.
%
%   Warning messages result if N is >= length(X), if X has repeated, or
%   nearly repeated, points, or if X might need centering and scaling.
%
%   Example: simple linear regression with polyfit
%
%     % Fit a polynomial p of degree 1 to the (x,y) data:
%       x = 1:50;
%       y = -0.3*x + 2*randn(1,50);
%       p = polyfit(x,y,1);
%
%     % Evaluate the fitted polynomial p and plot:
%       f = polyval(p,x);
%       plot(x,y,'o',x,f,'-')
%       legend('data','linear fit')
%
%   Class support for inputs X,Y:
%      float: double, single
%
%   See also POLY, POLYVAL, ROOTS, LSCOV.

%   Copyright 1984-2021 The MathWorks, Inc.

if numel(x) ~= numel(y)
    error(message('MATLAB:polyfit:XYSizeMismatch'))
end

x = x(:);
y = y(:);

if nargin < 4 || isempty(w);    w = ones(numel(x), 1); 
else                            w =w(:);                end


outputClass = superiorfloat(x,y);

if nargout > 2
    [sx, mx] = std(x);
    mu = [mx; sx];
    x = (x - mu(1))/mu(2);
end

% Construct the Vandermonde matrix V = [x.^n ... x.^2 x ones(size(x))]
V(:,n+1) = ones(length(x),1,class(x));
for j = n:-1:1
    V(:,j) = x.*V(:,j+1);
end

% Convert y to the same class as V
y1 = cast(full(y), class(V));

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % Modify least squares problem to allow for weights % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Solve least squares problem p = V\y to get polynomial coefficients p.
% [p, rankV, QRfactor, perm] = matlab.internal.math.leastSquaresFit(V,y1);
p = lscov(V, y1, w); 
% rankV = rank(V); 

% Get correct output class
p = cast(p, outputClass);

% Issue warnings.
% if size(V,1) < size(V,2) 
%     warning(message('MATLAB:polyfit:PolyNotUnique'))
% elseif rankV < size(V,2)
%     if nargout > 2
%         warning(message('MATLAB:polyfit:RepeatedPoints'));
%     else
%         warning(message('MATLAB:polyfit:RepeatedPointsOrRescale'));
%     end
% end

if nargout > 1
    S = []; 
%     r = y - V*p;
%     % S is a structure containing three elements: the triangular factor
%     % from a QR decomposition of the Vandermonde matrix, the degrees of
%     % freedom and the norm of the residuals.
%     minmn = min(size(V));
%     R = triu(QRfactor(1:minmn, :)); % extract R
%     perminv(perm) = 1:length(perm);
%     S.R = R(:,perminv);
%     S.df = max(0,length(y) - (n+1));
%     S.normr = norm(r);
end

p = p.'; % Polynomial coefficients are row vectors by convention.
