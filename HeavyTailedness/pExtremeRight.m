function per = pExtremeRight(x)
%PEXTREMERIGHT Summary of this function goes here
%   Returns P(X > Q_3(F) + 3*IQR(F))
per = nnz(x > 4*quantile(x, 0.75)-3*quantile(x, 0.25))/numel(x);
end

