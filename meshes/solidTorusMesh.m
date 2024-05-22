function [v,f] = solidTorusMesh(R, r, H)
%% SOLIDTORUSMESH Generate faces and vertices of solid torus mesh
%% Examples
%   [v,f] = solidTorusMesh; 
%   [v,f] = solidTorusMesh(4,2,1.9); figure; tetramesh(f,v);  
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 

if nargin<1; R = 8; end
if nargin<2; r = R/2; end
if nargin<3; H = (R-r)/2; end

h = (R+r)/2; % middle radius

f = @floor;
[x,y,z] = ndgrid(-f(R):f(R), -f(R):f(R), -f(H):f(H)); % make sqaure grid
v = [x(:), y(:), z(:)];

x2 = h*x(:)./vecnorm(v(:,1:2),2,2);
y2 = h*y(:)./vecnorm(v(:,1:2),2,2);
z2 = zeros(size(x2)); 
v2 = [x2, y2, z2];

m = vecnorm((v-v2)./[(R-r)/2,(R-r)/2,H],2,2)<=1; % trim points outside torus
v = v(m,:); 

if nargout < 2; return; end

f = cuboidDelaunay(xyz2vol(v-min(v)+1,[],0)); 

end

