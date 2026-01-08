function varargout = synclim(axs, varargin)
%% Examples
%   figure; for ii = 1:4; ax(ii) = nexttile; plot(ii:ii+3); end; synclim(ax, @ylim)
%   figure; for ii = 1:4; ax(ii) = nexttile; imagesc(magic(10*ii)); axis('image'); colorbar; end; synclim(ax, @clim);  
%   figure; tl = multiplot(2:4, @(x) plot(1:x)); [a,b] = synclim(tl.Children, @xlim, @ylim); 
%   
%


varargout = cell(1, nargin-1); 
for ii = 1:length(varargin)
    f = varargin{ii}; 
    ll = cell2mat(arrayfun(@(x) f(x), axs(:), 'Uni', 0));   % Limits over all axes
    varargout{ii} = [min(ll(:,1)), max(ll(:,2))];           % Min and max
    arrayfun(@(x) f(x, varargout{ii}), axs(:));             % Set
end

end
