function s = scat3c(xyz, varargin)
%% SCAT3C 3-D colored scatterplot 
%% Examples
%   figure; scat3c(eye(3), 'filled'); 
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

s = scatter3(xyz(:,1), xyz(:,2), xyz(:,3), [], (1:height(xyz))', varargin{:}); 
colorbar; 
if exist('addScatterLabels', 'file') addScatterLabels(s); end
end