function [v,f,r] = yinyang(varargin)

n = varargin{1}; 
[v,f] = circleMesh(varargin); 
m = v(:,1) > 0; 
m( vecnorm(v(:,[1,2]) - [0, +n/2],2,2) < n/2 ) = true; 
m( vecnorm(v(:,[1,2]) - [0, -n/2],2,2) < n/2 ) = false; 
m( vecnorm(v(:,[1,2]) - [0, +n/2],2,2) < n/4 ) = false; 
m( vecnorm(v(:,[1,2]) - [0, -n/2],2,2) < n/4 ) = true; 
r = m+1; 

end

