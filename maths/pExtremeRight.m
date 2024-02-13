function per = pExtremeRight(x)
%% PEXTREMERIGHT Probability of 'extreme right' outliers
%% Syntax
%  pER = pExtremeRight(x)
%
%
%% Examples
%   pExtremeRight(exprnd(1, 10000, 1))
% 
% 
%% Description
% `pER = pExtremeRight(x)` non-parametrically calculates the frequency of
% 'extreme right' outliers, in the distribution given by the random samples in
% `x`. Here, an outlier is extreme right if it is more than three times the IQR
% above the third quartile. 
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 
%% See Also
% "Measuring heavy-tailedness of distributions", Pavlina K. Jordanova and Monika
% P. Petkova, AIP Conference Proceedings 1910, 060002 (2017),
% https://doi.org/10.1063/1.5013996
%
%

% returns P(X > Q_3(F) + 3*IQR(F))
per = nnz(x > 4*quantile(x, 0.75)-3*quantile(x, 0.25))/numel(x);
end

