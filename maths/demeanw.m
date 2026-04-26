function out = demeanw(A, w, varargin)
out = A - meanw(A, w, varargin{:}); 
end
