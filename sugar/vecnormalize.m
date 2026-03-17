function N = vecnormalize(A, varargin)
%% Syntax
%  N = vecnormalize(A); 
%  N = vecnormalize(A,dim); 
%  N = vecnormalize(A,p,dim); 
%
%

N = A ./ vecnorm(A, varargin{:}); 

end

