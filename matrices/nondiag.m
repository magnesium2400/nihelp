function out = nondiag(X)
out = X(~eye(size(X))); 
end
