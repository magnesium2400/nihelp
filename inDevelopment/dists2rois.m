function [out, idx] = dists2rois(varargin)

%% Prelims
ip = inputParser;
ip.addRequired('dists', @isnumeric);
ip.addRequired('npts_or_pts');
ip.addParameter('isPoint', false);
ip.addParameter('seed', []);

ip.addParameter('distance', []);
ip.addParameter('neighbor', []);
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
area        = ipr.area;
va          = ipr.VertexAreas;


%% Error checking
assert(sum(cellfun(@isempty, {distance, neighbor, area}) ~= 2), ...
    'Please specify exactly one constraint (distance, neighbor, or area)');

if ~isempty(distance)
    validateattributes(distance, {'numeric'}, {'vector', 'numel', 2});
    assert(distance(1) <= distance(2), 'Distance constraint must be ascending [min max]');
elseif ~isempty(neighbor)
    validateattributes(neighbor, {'numeric'}, {'vector', 'numel', 2, 'integer', 'positive'});
    assert(neighbor(1) <= neighbor(2), 'Neighbor constraint must be ascending [min max]');
elseif ~isempty(area)
    validateattributes(area, {'numeric'}, {'vector', 'numel', 2});
    assert(area(1) <= area(2), 'Area constraint must be ascending [min max]');
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
elseif ~isempty(area)
    [~,I] = sort(d(:,idx), 1, 'ascend');
    vacs = cumsum(va(I),1); % vertex area cumulative sum
    mask = (area(1)<=vacs & vacs<=area(2));
    y = arrayfun(@(ii) I(mask(:,ii),ii),        (1:nr)', 'Uni', 0);
    x = arrayfun(@(n)  repmat(n, size(y{n})),   (1:nr)', 'Uni', 0);
    out = full(sparse(cell2mat(y), cell2mat(x), 1, nv, nr));
end


end

