function l = lims(l)
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

if nargin == 0
    l = struct('xlim', xlim, 'ylim', ylim, 'zlim', zlim);
else
    xlim(l.xlim); ylim(l.ylim); zlim(l.zlim);
end

end
