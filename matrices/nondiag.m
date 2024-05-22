function out = nondiag(X)
%% NONDIAG Offdiagonal entries of matrix
out = X(~eye(size(X))); 
end
