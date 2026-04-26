function M = meanw(A, w, varargin)
[w, sa] = weights2spmat(w, height(A));
M = sum(w * A, varargin{:})/sa; 
end
