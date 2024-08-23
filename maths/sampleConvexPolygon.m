function points = sampleConvexPolygon(verts, nPoints)
%% SAMPLECONVEXPOLYGON Sample points inside convex polygon with ordered vertices
%% Examples
%   p = sampleConvexPolygon([0 0; -1 0; 0 1; 1 1; 1 0], 100);
%   v = [0 0; -1 0; 0 1; 1 1; 1 0]; p = sampleConvexPolygon(v, 10000); figure; scatter(v(:,1),v(:,2),'filled'); hold on; scatter(p(:,1),p(:,2),'.');
%   rng(2); t = sort(rand(20,1)*2*pi); v = [cos(t),sin(t)]; p = sampleConvexPolygon(v, 10000); figure; scatter(v(:,1),v(:,2),'filled'); hold on; scatter(p(:,1),p(:,2),'.');
%
%
%% See Also
% `https://blogs.sas.com/content/iml/2020/10/19/random-points-in-triangle.html`
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
v1 = verts(1,:); 
verts = verts - v1; % move first vertex to zero (simplifies point selection too)
n = height(verts); 
if width(verts) == 2; verts(:,3) = 0; end


%% Triangulation
faces = [ones(1,n-2); 2:n-1 ; 3:n]';
a = calcFaceArea(verts, faces); 
a = cumsum(a)./sum(a);

id = n-1 - sum(rand(nPoints,1) < a',2); % Sample triangles based on areas


%% Choose random points inside each triangle
w = rand(nPoints,2);                % sample parameters
w = w + (sum(w,2) > 1).*(1-2*w);    % w --> 1-w if sum is greater than 1

points = w(:,1).*verts( faces(id,2), :) + w(:,2).*verts(faces(id,3), :); 
points = points(:,1:width(v1)) + v1; 


end
