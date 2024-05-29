function ax = addColorbarLine(cb, yval, linestyle)
%% ADDCOLORBARLINE Adds horizontal line to colorbar at specified value
%% Examples
%   figure; imagesc(magic(3)); cb = colorbar; addColorbarLine(cb,3); 
%   figure; imagesc(magic(3)); cb = colorbar; addColorbarLine(cb,3, {'-.', 'LineWidth', 2}); 
% 
% 
%% Usage Notes
% This is quite a simple function, but its functionality is somewhat unstable.
% In particular, the line will not be correctly placed if the width of the
% figure is changed after generation of the line.
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

if nargin < 3 || isempty(linestyle); linestyle = {}; end

ax = axes('Position', cb.Position, 'Units', cb.Units);
axis(ax, 'off'); 
ylim(ax, cb.Limits); 

yline(ax, yval, linestyle{:}); 

end
