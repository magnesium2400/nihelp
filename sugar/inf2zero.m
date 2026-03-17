function X = inf2zero(X)
X(isinf(X)) = 0; 
end