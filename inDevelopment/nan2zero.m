function X = nan2zero(X)
X(isnan(X)) = 0; 
end
