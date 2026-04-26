function N = normalizew(A, w, varargin)
N = demeanw(A, w, varargin{:})./sqrt(varw(A, w, varargin{:})); 
end
