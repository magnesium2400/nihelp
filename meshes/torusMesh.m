function [v,f] = torusMesh(n,R,r,H)
%% TORUSMESH Generate vertices and faces of toroidal mesh
%% Examples
%   v = torusMesh; figure; scatter3(v(:,1), v(:,2), v(:,3)); 
%   [v,f] = torusMesh(10); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none'); axis equal;
%   [v,f] = torusMesh(45,10,3,7); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', calcFaceArea(v,f)); axis equal; colorbar;
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
[theta, phi] = meshgrid((1:n)/n*2*pi);
c=(R+r)/2;
d=(R-r)/2;

x=c*cos(theta)+d*cos(phi).*cos(theta);
y=c*sin(theta)+d*cos(phi).*sin(theta);
z=H*sin(phi);
v=[x(:),y(:),z(:)];

if nargout < 2; return; end


%% Make faces
f = []; %#ok<*AGROW>

% upper triangles
for ii = 1:n 
    for jj = 1:n-1; f = [f; (ii-1)*n+jj, (ii-1)*n+jj+1, ii*n+jj+1]; end 
    f = [f; ii*n, (ii-1)*n+1, ii*n+1]; 
end

% lower triangles
for ii = 1:n 
    for jj = 1:n-1; f = [f; (ii-1)*n+jj, ii*n+jj+1, ii*n+jj]; end 
    f = [f; ii*n, ii*n+1, (ii+1)*n];
end

f = mod(f-1,n^2)+1;


end

%% Old method
% [x,y,z] = sphere(n);
% x = x(2:end,2:end);
% y = y(2:end,2:end);
% z = z(2:end,2:end);
% x = x*(R-r)+r*(cos(2*pi*(1:n)/n-pi));
% y = y*(R-r)+r*(sin(2*pi*(1:n)/n-pi));
% z = sqrt(0.25-(sqrt(1-z.^2)-0.5).^2).*sign(z)*(R-r);
% v = [x(:),y(:),z(:)];