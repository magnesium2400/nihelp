function [v,f] = equalTorusMesh(n,R,r)
%% EQUALTORUSMESH Generate vertices and faces of toroidal mesh with equal faces
%% Examples
%   v = equalTorusMesh; figure; scatter3(v(:,1), v(:,2), v(:,3)); 
%   [v,f] = equalTorusMesh(21); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none'); axis equal; view(3);  
%   [v,f] = equalTorusMesh(98,3,7); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData',(1:height(v)).', 'EdgeColor', 'none'); axis equal; view(3); colormap([hsv;hsv]);
%
%   [v,f] = equalTorusMesh(60,3,7); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData',calcFaceArea(v,f), 'EdgeColor', 'k'); axis equal tight; view(3); colorbar;
%   [v,f] = torusMesh(60,3,7);      figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData',calcFaceArea(v,f), 'EdgeColor', 'k'); axis equal tight; view(3); colorbar;
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
if nargin<2; R = 2; end % outer radius
if nargin<3; r = 1; end % inner radius

c=(R+r)/2; % distance from centre
d=(R-r)/2; % tube radius


%% Find phi angles s.t. area will be approx equal for each strip around torus
% numerically solve for x+k*sin(x)=phiTarget (where phiTarget is uniform)
phiTarget = (1:n)/n*2*pi; 
syms x;
for ii = 1:n
    phi(ii) = vpasolve(...
        x + d/c*sin(x) == phiTarget(ii), ...
        x, [0, 2*pi] );
end
phi = double(phi); 
clear x phiTarget; 


%% Vertices and initial faces
% theta remains uniformly distributed around circle
[thetaOrig, phi] = meshgrid((1:n)/n*2*pi, phi); 

% Modify angles to generate equilateral (approx) triangles, rather than
% right-angled. This does not change the area of each strip, but makes triangles
% within a strip more similar.
theta = thetaOrig + (0:n-1)'/n*pi; 

% Convert to Cartesian to get vertex locations
x=c*cos(theta)+d*cos(phi).*cos(theta);
y=c*sin(theta)+d*cos(phi).*sin(theta);
z=d*sin(phi);
v=[x(:),y(:),z(:)];

if nargout < 2; return; end


%% Add faces around perimeter (of parameter space)
% Start with delaunay in parameter space
f = delaunay(thetaOrig(:),phi(:)); %#ok<*AGROW>

f = [ f; ((1:n)'+[-1,ceil(n/2)+1,0])          *n+[1,0,1] ]; % upper triangles in horiz strip
f = [ f; ((1:n)'+[-1,ceil(n/2)  ,ceil(n/2)+1])*n+[1,0,0] ]; % lower triangles in horiz strip

f = [ f; (1:n-1)'+[0,1,n*(n-1)+1] ];         % upper triangles in vert strip
f = [ f; (1:n-1)'+[0,  n*(n-1)+1,n*(n-1)] ]; % lower triangles in vert strip

f = mod(f-1,n^2)+1;


end


