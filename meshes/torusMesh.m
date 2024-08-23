function [v,f] = torusMesh(n,R,r,H)
%% TORUSMESH Generate vertices and faces of toroidal mesh
%% Examples
%   v = torusMesh; figure; scatter3(v(:,1), v(:,2), v(:,3)); 
%   [v,f] = torusMesh(21); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none'); axis equal; view(3);  
%   [v,f] = torusMesh(98,10,3,7); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData',(1:height(v)).', 'EdgeColor', 'none'); axis equal; view(3); colormap([hsv;hsv]);
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


%% Prelims
if nargin<1; n = 20; end
if nargin<2; R = 2; end
if nargin<3; r = 1; end
if nargin<4; H = (R-r)/2; end


%% Draw vertices
[thetaOrig, phi] = meshgrid((1:n)/n*2*pi);
c=(R+r)/2;
d=(R-r)/2;

theta = thetaOrig + (0:n-1)'/n*pi; 

x=c*cos(theta)+d*cos(phi).*cos(theta);
y=c*sin(theta)+d*cos(phi).*sin(theta);
z=H*sin(phi);
v=[x(:),y(:),z(:)];

if nargout < 2; return; end


%% Make faces
% Start with delaunay in parameter space
f = delaunay(thetaOrig(:),phi(:)); %#ok<*AGROW>

f = [ f; ((1:n)'+[-1,ceil(n/2)+1,0])          *n+[1,0,1] ]; % upper triangles in horiz strip
f = [ f; ((1:n)'+[-1,ceil(n/2)  ,ceil(n/2)+1])*n+[1,0,0] ]; % lower triangles in horiz strip

f = [ f; (1:n-1)'+[0,1,n*(n-1)+1] ];         % upper triangles in vert strip
f = [ f; (1:n-1)'+[0,  n*(n-1)+1,n*(n-1)] ]; % lower triangles in vert strip

f = mod(f-1,n^2)+1;


end
