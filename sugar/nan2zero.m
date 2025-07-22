function X = nan2zero(X)
%% NAN2ZERO Converts NaNs to zeros
%% Examples
%   a = magic(3); a(:,1) = NaN; nan2zero(a)
X(isnan(X)) = 0; 
end
