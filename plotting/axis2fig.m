function [fig, ax2] = axis2fig(ax,fig,flag)
%% AXIS2FIG Copies an axis to a (new) figure
%% Examples
%   figure; for ii = 5:10; imagesc(nexttile, magic(ii)); end; axis2fig(); 
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


if nargin < 1 || isempty(ax);   ax = gca();         end
if nargin < 2 || isempty(fig);  fig = figure();     end
if nargin < 3 || isempty(flag); flag = 'maximise';  end

ax2 = copyobj(ax,fig); 
copyobj(ax.Children, ax2); 

switch flag
    case "maximise"
        set(ax2,'Units', 'normalized'); 
        set(ax2, 'Position', [0 0 1 1]); 
end

end