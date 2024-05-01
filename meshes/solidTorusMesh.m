function [v,f] = solidTorusMesh(R, r, H)

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


%% get faces in parameter space
% generate two tori with diffent angles to get faces near boundary (due to
% periodicity)

nverts = height(v); 
t = atan2(v(:,2),v(:,1)); 
r = vecnorm(v(:,1:2),2,2); 

vn = [v;v]; 
rn = [r;r];
tn = [t; t+2*pi-4*pi*(t>0)];   % loop tori around

f = delaunay(tn, rn, vn(:,3)); % get faces
f(all(f>nverts,2),:) = [];     % remove faces connected to extraneous verts
f = mod(f-1,nverts)+1;         % reindex

end

