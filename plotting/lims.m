function l = lims(varargin)
%% LIMS Set or query x-axis, y-axis, and z-axis limits
%% Examples
%   figure; scatter(1:10,1:10, 1:10); lims
%   figure; plot(1:10); l = lims; hold on; plot(15:-1:1); lims(l);
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

[ax,args,nargs] = axescheck(varargin{:}); 
if isempty(ax); ax = gca(); end

if nargs == 0
    l = struct('xlim', xlim(ax), 'ylim', ylim(ax), 'zlim', zlim(ax));
else
    xlim(ax, args{1}.xlim); ylim(ax, args{1}.ylim); zlim(ax, args{1}.zlim);
end

end
