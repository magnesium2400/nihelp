function C = covw(varargin)
% Note that this returns the weighted covariance between each column of A and B
if nargin==2
    A = varargin{1}; 
    B = A; 
    w = varargin{2}; 
elseif nargin==3
    A = varargin{1}; 
    B = varargin{2}; 
    w = varargin{3}; 
end

[w, sa] = weights2spmat(w, height(A)); 
A = demeanw(A, w); 
B = demeanw(B, w); 
C = gramw(A,B,w)/sa; 

end
