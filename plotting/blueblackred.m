function cmap = blueblackred(varargin)
%% BLUEBLACKRED Diverging colormap of green/blue, then black, then red/yellow
%% Examples
%   figure; colormap(blueblackred); colorbar;
%   figure; clim([-1 +1]); colormap(blueblackred); colorbar;  
%   figure; clim([-9 -5]); colormap(blueblackred); colorbar; 
%   figure; clim([-9 +5]); colormap(blueblackred); colorbar; 
%   figure; clim([-9 +5]); colormap(blueblackred('autoscale', false)); colorbar; 
%   figure; colormap(blueblackred(5)); colorbar; 
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



cmap = bluewhitered_mg(varargin{:}, 'colors', [0 1 0; 0 0 1; 0 0 0; 1 0 0; 1 1 0]);
end
