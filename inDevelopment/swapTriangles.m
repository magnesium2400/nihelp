function faces = swapTriangles(verts, faces, nSwaps, varargin)
%% SWAPTRIANGLES Swap adjacent triangles in 2-D mesh triangulation
%% Usage Notes
% This algorithm is suboptimal and may fail for non-planar 3d meshes. In
% particular, because it is difficult to establish the convexity of non-planar
% quadrilaterals. 
%
%
%% Examples
%   v=rand(100,2); f=delaunay(v); f2=swapTriangles(v,f,10); 
%   rng(1); v=rand(100,2); f=delaunay(v); pf=@(x) patch('Vertices',v,'Faces',x,'FaceColor','none'); figure; nexttile; pf(f); nexttile; pf(swapTriangles(v,f,10));
%   rng(2); v=rand(100,2); f=delaunay(v); pf=@(x,y) patch('Vertices',v,'Faces',x,'FaceColor','none','EdgeColor',y); figure; pf(f,'r'); hold on; pf(swapTriangles(v,f,10),'k');
%   rng(3); [v,f] = hexMesh(9,-1); pf=@(x,y) patch('Vertices',v,'Faces',x,'FaceColor','none','EdgeColor',y); figure; pf(f,'r'); hold on; pf(swapTriangles(v,f,100),'k');
%   rng(3); [v,f] = hexMesh(9,10); pf=@(x,y) patch('Vertices',v,'Faces',x,'FaceColor','none','EdgeColor',y); figure; pf(f,'r'); hold on; pf(swapTriangles(v,f,100),'k');
%   rng(4); n=10; [v,f] = squareMesh3(10); pf=@(x,y) patch('Vertices',v,'Faces',x,'FaceColor','none','EdgeColor',y); figure; pf(f,'r'); hold on; pf(swapTriangles(v,f,n),'k');
%   rng(5); [v,f] = circleMesh3(10,-1,@(x,y)x); pf=@(x,y) patch('Vertices',v,'Faces',x,'FaceColor','none','EdgeColor',y); figure; pf(f,'r'); hold on; pf(swapTriangles(v,f,100),'k');
% 
% 
%% TODO
% * consider adding option to threshold triangle quality when doing swaps
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


%% Prelims
ip = inputParser; 
ip.addRequired('verts', @(x) ismatrix(x) && (size(x,2) == 2 || size(x,2) == 3)); 
ip.addRequired('faces', @(x) ismatrix(x) && size(x,2) == 3); 
ip.addRequired('nSwaps', @(x) isscalar(x) && x > 0 && mod(x,1)==0); 

ip.addParameter('permitNonplanar', 0);
ip.addParameter('minimumFaceArea', min(nonzeros(calcFaceArea(verts, faces))) / 10 );
ip.addParameter('maxSwaps', Inf);  % Maximum number of swaps per face

ip.parse(verts, faces, nSwaps, varargin{:}); 
verts   = ip.Results.verts; 
faces   = ip.Results.faces; 
nSwaps  = ip.Results.nSwaps; 
maxSwaps = ip.Results.maxSwaps; 

if maxSwaps * height(faces) < 2 * nSwaps
    error('Not enough swaps per face permitted'); 
end


%% Calculations
counter = 0; 
swaps = zeros(height(faces), 1); 
faceIsAllowed = true(height(faces),1);
allowedFaces = 1:height(faces); 

while counter < nSwaps

    tr = triangulation(faces, verts); 
    id = allowedFaces( randi(numel(allowedFaces)) );
    nidx = neighbors(tr, id); 
    nidx = nidx(randperm(3)); % randomly reorder
    
    % Test if any of the neighbouring faces are suitable
    suitable = false; 
    for ii = 1:3
        nid = nidx(ii);
        if isnan(nid) || ~faceIsAllowed(nid); continue; end

        f1 = faces(id,:);
        f2 = faces(nid,:);

        if isCollinear(verts(unique([f1,f2]),:), ip.Results) || ...
                ~isPlanarConvex(verts, [f1; f2], ip.Results)
            continue
        else
            suitable = true; 
            break
        end
    end
    if ~suitable; continue; end

    % There will be two vertices used twice (say A and B), and two vertices
    % used once (say X and Y) e.g. [A B X; A Y B]. WLOG in the first face
    % change A to Y, and in the second face change B to X.
    [vn, vid] = groupcounts([f1,f2]');
    vrep = vid(vn==2); % vertices which are repeated
    f1n = renumber(f1, setdiff(vid,f1), vrep(1));
    f2n = renumber(f2, setdiff(vid,f2), vrep(2));
    faces(id,:) = f1n;
    faces(nid,:) = f2n;

    swaps(id)  = swaps(id)  + 1;
    swaps(nid) = swaps(nid) + 1;
    if swaps(id)  == maxSwaps
        faceIsAllowed(id) = false;
        allowedFaces = setdiff(allowedFaces, id);  
    end
    if swaps(nid) == maxSwaps
        faceIsAllowed(nid) = false; 
        allowedFaces = setdiff(allowedFaces, nid); 
    end

    counter = counter + 1; 

end


end


%% Helpers
function out = isCollinear(v, ipr)
% Check if any 3 out of 4 points are collinear
% If any of the faces have area zero, points are collinear
if width(v) == 2; v(:,3) = 0; end
a = calcFaceArea(v, [1 2 3; 1 2 4; 1 3 4; 2 3 4]);
out = any(a < ipr.minimumFaceArea); 
end


function out = isCoplanar(v, ipr)
% Checks if quad has all points coplanar
% https://en.wikipedia.org/wiki/Coplanarity
if width(v) == 2; v(:,3) = 0; end
x = @(n) v(n,:); 
out = abs(cross(x(2)-x(1), x(4)-x(1)) * (x(3)-x(1))') < ...
    ipr.permitNonplanar + eps;
end


function out = isPlanarConvex(v,f, ipr)
% Checks if planar quad formed by two triangles is convex
if width(v) == 2; v(:,3) = 0; end
% If not planar - skip
if ~isCoplanar(v(unique(f),:), ipr)
    out = false; return; 
end 

% Proceed only if quad is convex
quad = makeQuadrilateral(f); 
v = v(quad,:); 
x = @(n) v(n,:); 

% Project from 3-d space to 2-d space with 3 vertices at (0,0), (1,0), (0,1)
s1 = x(2) - x(1); 
s2 = x(4) - x(1); 
l = (x(3) - x(1)) / [s1; s2]; % Find fourth vertex in terms of other vertices
out = (l(1) >= 0) && (l(2) >= 0) && (l(1)+l(2)>=1);  % Check convexity

% sides = v(quad([2;3;4;1]),:) - v(quad,:);
% 
% % Get unit normals (from cross products) at each vertex
% cps = arrayfun2mat(@(x) cross(sides(x,:), sides(mod(x,4)+1,:)),  (1:4)');
% cps = cps./vecnorm(cps,2,2);
% 
% % Polygon is convex if all normals point in same direction
% out = allclose(cps - cps(1,:), 0, 1e-3);

end


function out = makeQuadrilateral(f)
% Joins two adjacent triangles (with verts in the same order) into a quadrilateral
d = setdiff(f(2,:), f(1,:));                % find point not in first triangle
% d = f(2, cellfun(@isempty, arrayfun(@(x) find(x==f(1,:)), f(2,:), 'UniformOutput', false))   );                % find point not in first triangle
prevIdx = mod(find(f(2,:) == d)-1-1,3)+1;   % find point in second triangle that preceeds it
prev = f(2,prevIdx);
id = find(f(1,:) == prev);

out = zeros(1,4);                          % assemble quadrilateral in that order
out(1:id) = f(1,1:id);
out(id+1) = d;
out(id+2:end) = f(1,id+1:end);

end

