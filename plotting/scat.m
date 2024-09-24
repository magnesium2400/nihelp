function s = scat(xyData,varargin)
%% SCAT wrapper to simplify plotting
if width(xyData)==3; warning('Plotting 3d data in 2d'); end
s = scatter(xyData(:,1), xyData(:,2), varargin{:});
end

