function h = histInteger(varargin)
[ax, args, ~] = axescheck(varargin{:});
if isempty(ax); ax = gca; end
data = args{1};
edges = (min(data,[], 'all')-0.5):(max(data,[],'all')+0.5);
h = histogram(ax, data, edges, args{2:end});
end
