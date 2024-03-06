function pmr = pMildRight(x)
%% PMILDRIGHT Probability of 'mild right' outliers
%% Syntax
%  pMR = pMildRight(x)
%
%
%% Examples
%   pMildRight(exprnd(1, 10000, 1))
% 
% 
%% Description
% `pER = pMildRight(x)` non-parametrically calculates the frequency of 'mild
% right' outliers in the distribution given by the random samples in `x`. Here,
% an outlier is mild right if is between 1.5 and 3 times the IQR above the third
% quartile.
%
%
%% TODO
% * docs
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


%   Returns P(X > Q_3(F) + 1.5*IQR(F))
pmr = nnz(x > 2.5*quantile(x, 0.75)-1.5*quantile(x, 0.25))/numel(x) - pMildRight(x);
end

