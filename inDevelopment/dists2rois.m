function [out, idx] = dists2rois(varargin)

%% Prelims
ip = inputParser;
ip.addRequired('dists', @isnumeric);
ip.addRequired('npts_or_pts');
ip.addParameter('isPoint', false);
ip.addParameter('seed', []);

ip.addParameter('distance', []);
ip.addParameter('neighbor', []);
ip.addParameter('voronoi',  []); 
ip.addParameter('triangle', []);
ip.addParameter('vertices', []);
ip.addParameter('area', []);
ip.addParameter('VertexAreas', []);

ip.parse(varargin{:});
ipr = ip.Results;


%% Setup
d   = ipr.dists;
nv  = length(ipr.dists);
nr  = ipr.npts_or_pts;
s   = ipr.seed;

if strcmp(nr, 'all')
    idx = 1:width(d); 
    nr = length(idx); 
elseif isscalar(nr) && ~ip.Results.isPoint
    if ~isempty(s); rng(s); end
    idx = randsample(nv, nr)';
elseif isvector(nr)
    idx = nr(:)';
    nr = length(idx);
else
    error('Please specify npts_or_pts: as "all", or a number of seed pts, or seed pt indexes');
end

distance    = ipr.distance;
neighbor    = ipr.neighbor;
voronoi     = ipr.voronoi;
triangle    = ipr.triangle; 
area        = ipr.area;
va          = ipr.VertexAreas;
verts       = ipr.vertices;


%% Error checking
assert(sum(cellfun(@isempty, {distance, neighbor, area}) ~= 2), ...
    'Please specify exactly one constraint (distance, neighbor, or area)');

%%% `area` option can appect different area constraints for each roi
%%% need to change other options to be the same
if ~isempty(distance)
    validateattributes(distance, {'numeric'}, {'vector', 'numel', 2});
    assert(distance(1) <= distance(2), 'Distance constraint must be ascending [min max]');
elseif ~isempty(neighbor)
    validateattributes(neighbor, {'numeric'}, {'vector', 'numel', 2, 'integer', 'positive'});
    assert(neighbor(1) <= neighbor(2), 'Neighbor constraint must be ascending [min max]');
elseif ~isempty(voronoi)
    validateattributes(voronoi, {'numeric', 'logical'}, {'vector'});
elseif ~isempty(triangle)
    validateattributes(triangle, {'numeric'}, {'vector', 'numel', 2, 'positive'});
    assert(triangle(1) <= triangle(2), 'Triangle constraint must be ascending [min max]');
    assert(~isempty(verts), 'Vertices is required for triangle constraint');
elseif ~isempty(area)
    if isvector(area)
        area = area(:).*ones(2,nr); 
    end
    validateattributes(area, {'numeric'}, {'size', [2,nr]});
    assert(all(diff(area)>0), 'Area constraint must be ascending [min max]');
    assert(~isempty(va), 'VertexAreas is required for area constraint');
end


%% Calc
if ~isempty(distance)
    out = +( (distance(1)<=d(:,idx)) & (d(:,idx)<=distance(2)) );
elseif ~isempty(neighbor)
    [~,I] = sort(d(:,idx), 1, 'ascend');
    y = I(neighbor(1):neighbor(2),:);
    x = repmat(1:nr,height(y),1);
    out = full(sparse(y, x, 1, nv, nr));
elseif ~isempty(voronoi)
    d2 = d(:,voronoi); 
    [~,out] = min(d2,[],2); 
elseif ~isempty(triangle)
    % 3 random points, each with specified radius from each other
    A = idx(:)'; % this is the first point on the triangle, rather than the centre
    [~,B] = max( rand(height(d),numel(A)).*(triangle(1)<=d(:,A)&d(:,A)<=triangle(2)) ,[],1);
    [~,C] = max( rand(height(d),numel(A)).*(triangle(1)<=d(:,A)&d(:,A)<=triangle(2)).*(triangle(1)<=d(:,B)&d(:,B)<=triangle(2)) ,[],1);
    % get triangle interiors
    s1 = sign(dot(cross(verts(B,:), verts(C,:)), verts(A,:), 2));
    s2 = sign(dot(cross(verts(C,:), verts(A,:)), verts(B,:), 2));
    s3 = sign(dot(cross(verts(A,:), verts(B,:)), verts(C,:), 2));
    S1 = sign(cross(verts(B,:), verts(C,:)) * verts');
    S2 = sign(cross(verts(C,:), verts(A,:)) * verts');
    S3 = sign(cross(verts(A,:), verts(B,:)) * verts');
    out = (s1==S1)' & (s2==S2)' & (s3==S3)';
 elseif ~isempty(area)
    [~,I] = sort(d(:,idx), 1, 'ascend');
    vacs = cumsum(va(I),1); % vertex area cumulative sum
    mask = (area(1,:)<=vacs & vacs<=area(2,:));
    y = arrayfun(@(ii) I(mask(:,ii),ii),        (1:nr)', 'Uni', 0);
    x = arrayfun(@(n)  repmat(n, size(y{n})),   (1:nr)', 'Uni', 0);
    out = full(sparse(cell2mat(y), cell2mat(x), 1, nv, nr));
end


end


    % heron = @(x,y,z) sqrt((x+y+z).*(x+y-z).*(x+z-y).*(y+z-x))/4;
    % dAB = d(A,B); dAC = d(A,C); dBC = d(B,C);
    % A_ABC = heron(dAB,dAC,dBC); 
    % dPA = d(:,A); dPB = d(:,B); dPC = d(:,C); 
    % A_PAB = heron(dAB,dPA,dPB); 
    % A_PAC = heron(dAC,dPA,dPC); 
    % A_PBC = heron(dBC,dPA,dPC);
    % out = 1;