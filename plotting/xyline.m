function l = xyline(varargin)
%% XYLINE Draw y = x line (without changing axes limits)
%% Examples
%   rng(1); figure; scatter(sort(randn(10,1)), sort(randn(10,1))); xyline;
%   rng(1); figure; scatter(sort(randn(10,1)), sort(randn(10,1))/3); xyline;
%   rng(1); figure; scatter(sort(randn(10,1)), sort(randn(10,1))); xyline('LineWidth', 3, 'Color', [1 1 1]/2);
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


[ax,args,~] = axescheck(varargin{:}); 
if isempty(ax); ax = gca; end
washold = ishold(ax); hold(ax, 'on'); 

xl = xlim(ax); yl = ylim(ax); %xlm = ax.XLimMode; ylm = ax.YLimMode; 
mm = [min([xl(1),yl(1)]), max([xl(2),yl(2)])];

l = line(ax, mm, mm, args{:});

xlim(ax, xl); ylim(ax, yl); %set(ax, 'XLimMode', xlm); set(ax, 'YLimMode', ylm);  

if ~washold; hold(ax,'off'); end


end
