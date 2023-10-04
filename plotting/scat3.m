function s = scat3(varargin)
%% SCAT3 wrapper to simplify plotting
[ax, args] = axescheck(varargin{:});
if isempty(ax); ax = gca; end
xyzData = args{1};
s = scatter3(ax, xyzData(:,1), xyzData(:,2), xyzData(:,3), args{2:end});
end

