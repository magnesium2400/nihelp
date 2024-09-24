function [v,f] = sphereMesh(n, seed)
%% SPHEREMESH Generate vertices and faces of spherical mesh
%% Examples
%   v = sphereMesh; figure; scatter3(v(:,1),v(:,2),v(:,3)); 
%   [v,f] = sphereMesh(10); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none');
%   [v,f] = sphereMesh(99); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', (1:height(v)).', 'EdgeColor', 'none'); axis equal off; colormap(hsv); view(3); 
%   [v,f] = sphereMesh(45); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', calcFaceArea(v,f)); axis equal; colorbar;
%
%   v = sphereMesh([],'fib'); figure; scatter3(v(:,1),v(:,2),v(:,3)); 
%   [v,f] = sphereMesh(10,'fib'); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none');
%   [v,f] = sphereMesh(99,'fib'); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', (1:height(v)).', 'EdgeColor', 'none'); axis equal off; colormap(hsv); view(3); 
%   [v,f] = sphereMesh(45,'fib'); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', calcFaceArea(v,f)); axis equal; colorbar;
%
%   v = sphereMesh([],1); figure; scatter3(v(:,1),v(:,2),v(:,3)); 
%   [v,f] = sphereMesh(10,10); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none');
%   [v,f] = sphereMesh(99,99); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', (1:height(v)).', 'EdgeColor', 'none'); axis equal off; colormap(hsv); view(3); 
%   [v,f] = sphereMesh(45,45); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', calcFaceArea(v,f)); axis equal; colorbar;
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


if nargin > 1 && strcmpi(seed, 'fib')
    %% Fibonacci lattice
    n = n*(n-1) + 2; 
    theta = 2*pi*(0:n-1)'*2/(1+sqrt(5)); 
    phi = acos(1-2*((0:n-1)'+.5)/n); 
    
    x = cos(theta).*sin(phi); 
    y = sin(theta).*sin(phi); 
    z = cos(phi); 
    v = [x(:),y(:),z(:)];
    
    if nargout < 2; return; end
    f = convhull(v); 
    return;

elseif nargin > 1
    %% Or random points on sphere
    n = n*(n-1) + 2; 
    rng(seed); 
    v = randn(3,n)'; % so that increasing n only adds more points (doesn't change existing points) 
    v = v./vecnorm(v,2,2); 

    if nargout < 2; return; end
    f = convhull(v); 
    return;   

end




%% Otherwise generate regular vertices, excluding north and south pole for now
% phi adjusted to reduce variability in area of each face:
[theta, phi] = meshgrid( 2*pi*(1:n)/n , pi - acos(1-(1:2:2*n-3)/(n-1)) );

% % % conventaional formulation with greater variability in area between faces: 
% % % [theta, phi] = meshgrid( 2*pi*(1:n)/n , (1:n-1)/n*pi-pi/2 ); 

x = cos(theta).*sin(phi);
y = sin(theta).*sin(phi); 
z = cos(phi); 
v = [x(:),y(:),z(:)];

v = [0,0,-1; v; 0,0,1]; 

if nargout < 2; return; end


%% Generate faces
% delaunay triangulation in parameter space
f = delaunay(theta(:),phi(:));

% add triangles in vertical strip (between high & low values of theta) 
f = [f; (2:n-1)' + [ 0, -1, (n-1)^2-1 ] ];            % upper triangles 
f = [f; (2:n-1)' + [ 0,     (n-1)^2-1, (n-1)^2 ] ];   % lower triangles

% add triangles around top (#n(n-1)+1) and bottom (transiently at #0) vertex
f = [f; zeros(n,1), (0:n-1)'*(n-1)+1, [1:n-1,0]'*(n-1)+1];  % bottom
f = [f; [n*ones(n,1), [2:n,1]', (1:n)']*(n-1)+[1,0,0] ];    % top

% re-index faces based on poles being added
f = f(:, [1 3 2]) + 1;


end
