function h = histInteger(varargin)
[ax, args, ~] = axescheck(varargin{:});
if isempty(ax); ax = gca; end
data = args{1};
edges = (double(min(data(:)))-0.5):(double(max(data(:)))+0.5);
h = histogram(ax, data, edges, args{2:end});
end
