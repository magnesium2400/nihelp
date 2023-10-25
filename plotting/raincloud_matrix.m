function a = raincloud_matrix(X, cmap, plotOrder, varargin)

nData = size(X, 2);
if nargin < 2 || isempty(cmap);      cmap = lines(nData); end
if nargin < 3 || isempty(plotOrder); plotOrder = 1:nData; end


for jj = plotOrder
    a{jj} = raincloud_plot( ...
        X(:,jj), varargin{:}, ...
        'box_on', 1, 'box_dodge', 1, 'box_dodge_amount', (jj-0.5)/nData, ...
        'dot_dodge_amount', (jj-0.5)/nData, 'alpha', 0.5, 'color', cmap(jj,:)); %#ok<*AGROW> 
end


end
