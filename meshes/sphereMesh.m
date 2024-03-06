function [v,f] = sphereMesh(n)
%% SPHEREMESH Generate vertices and faces of spherical mesh
%% Examples
%   v = sphereMesh; figure; scatter3(v(:,1),v(:,2),v(:,3)); 
%   [v,f] = sphereMesh(10); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none');
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
if nargin<1; n = 20;  end


%% Generate vertices
% phi adjusted to reduce variability in area of each face:
[theta, phi] = meshgrid( 2*pi*(1:n)/n , acos(1-(1:2:2*n-3)/(n-1)) - pi/2 );
% conventaional formulation with greater variability in area between faces: 
% [theta, phi] = meshgrid( 2*pi*(1:n)/n , (1:n-1)/n*pi-pi/2 ); 

x = cos(phi).*cos(theta);
y = cos(phi).*sin(theta);
z = sin(phi);
v = [0,0,-1; x(:),y(:),z(:); 0,0,1];

if nargout < 2; return; end


%% Generate faces
% triangles around top and bottom vertex in intermediate strip 
% (between high and low indexed vertices)
f = [1,n^2-2*n+3,2 ; n,n^2-n+1,n^2-n+2]; %#ok<*AGROW>
% triangles around borrom vertex (1)
for ii=1:n-1; f=[f; 1,2+(n-1)*(ii-1),2+(n-1)*ii ]; end 
% triangles around top vertex (n^2-n+2)
for ii=1:n-1; f=[f; n^2-n+2,1+(n-1)*(ii+1),1+(n-1)*ii ]; end

% upper triangles in transverse strips
for ii=3:n; for jj=1:n-1; f=[f; ii+(n-1)*(jj-1), ii+(n-1)*jj, ii+(n-1)*(jj-1)-1]; end; end
% lower triangles in transverse strips
for ii=3:n; for jj=1:n-1; f=[f; ii+(n-1)*jj, ii+(n-1)*jj-1, ii+(n-1)*(jj-1)-1]; end; end
% triangles in vertical intermediate strip 
for ii=3:n; f=[f; ii,ii-1,n^2-2*n+ii ; ii,n^2-2*n+ii,n^2-2*n+ii+1 ]; end 


end

% % % % v = [x(:), y(:), z(:)];
% % % 
% % % % [x,y,z] = sphere(n);
% % % % x = x(2:end-1,2:end);
% % % % y = y(2:end-1,2:end);
% % % % z = z(2:end-1,2:end);
