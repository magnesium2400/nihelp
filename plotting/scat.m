function s = scat(xyData,varargin)
%% SCAT wrapper to simplify plotting
s = scatter(xyData(:,1), xyData(:,2), varargin{:});
end

