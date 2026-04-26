function V = varw(A, w, varargin)
[w, sa] = weights2spmat(w, height(A)); 
B = demeanw(A, w, varargin{:});
V = ssqw(B,w)/sa;
end
