function [v,f,r] = yinyang3(varargin)

n = varargin{1}; 
[v,f] = circleMesh3(varargin); 
m = v(:,1) > 0; 
m( vecnorm(v(:,[1,2]) - [0, +n/2],2,2) < n/2 ) = true; 
m( vecnorm(v(:,[1,2]) - [0, -n/2],2,2) < n/2 ) = false; 
m( vecnorm(v(:,[1,2]) - [0, +n/2],2,2) < n/4 ) = false; 
m( vecnorm(v(:,[1,2]) - [0, -n/2],2,2) < n/4 ) = true; 
r = m+1; 

end

