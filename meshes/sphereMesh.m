function [v,f] = sphereMesh(n)
%% SPHEREMESH Generate vertices and faces of spherical mesh
%% Examples
%   v = sphereMesh; figure; scatter3(v(:,1),v(:,2),v(:,3)); 
%   [v,f] = sphereMesh(10); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none');
%   [v,f] = sphereMesh(99); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', (1:height(v)).', 'EdgeColor', 'none'); axis equal off; colormap(hsv); view(3); 
%   [v,f] = sphereMesh(45); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', calcFaceArea(v,f)); axis equal; colorbar;
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
if nargin < 1 || isempty(n); n = 20;  end


%% Generate vertices, excluding north and south pole for now
% phi adjusted to reduce variability in area of each face:
[theta, phi] = meshgrid( 2*pi*(1:n)/n , pi - acos(1-(1:2:2*n-3)/(n-1)) );

% % % conventaional formulation with greater variability in area between faces: 
% % % [theta, phi] = meshgrid( 2*pi*(1:n)/n , (1:n-1)/n*pi-pi/2 ); 

z = cos(phi); 
y = sin(theta).*sin(phi); 
x = cos(theta).*sin(phi);
v = [x(:),y(:),z(:)];

if nargout < 2; v = [0,0,-1; v; 0,0,1]; return; end


%% Generate faces
% delaunay triangulation in parameter space
f = delaunay(theta(:),phi(:));

% add triangles in vertical strip (between high & low values of theta) 
f = [f; (2:n-1)' + [ 0, -1, (n-1)^2-1 ] ];            % upper triangles 
f = [f; (2:n-1)' + [ 0,     (n-1)^2-1, (n-1)^2 ] ];   % lower triangles

% add triangles around top (#n(n-1)+1) and bottom (transiently at #0) vertex
f = [f; zeros(n,1), (0:n-1)'*(n-1)+1, [1:n-1,0]'*(n-1)+1];  % bottom
f = [f; [n*ones(n,1), [2:n,1]', (1:n)']*(n-1)+[1,0,0] ];    % top

% add top and bottom vertices, and correspondingly re-index faces
v = [0,0,-1; v; 0,0,1];
f = f + 1;


end
