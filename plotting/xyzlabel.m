function xyzlabel(varargin)
[ax, args, nargs] = axescheck(varargin{:});
if isempty(ax); ax = gca(); end
if nargs < 1; xlabel(ax,'x'); else; xlabel(ax,args{1}); end
if nargs < 2; ylabel(ax,'y'); else; ylabel(ax,args{2}); end
if nargs < 3; zlabel(ax,'z'); else; zlabel(ax,args{3}); end
end

