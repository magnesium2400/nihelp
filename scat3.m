function s = scat3(xyzData, varargin)
%% SCAT3 wrapper to simplify plotting
s = scatter3(xyzData(:,1), xyzData(:,2), xyzData(:,3), varargin{:});
end

