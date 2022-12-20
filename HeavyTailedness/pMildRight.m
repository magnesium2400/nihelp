function pmr = pMildRight(x)
%PEXTREMERIGHT Summary of this function goes here
%   Returns P(X > Q_3(F) + 1.5*IQR(F))
pmr = nnz(x > 2.5*quantile(x, 0.75)-1.5*quantile(x, 0.25))/numel(x) - pExtremeRight(x);
end

