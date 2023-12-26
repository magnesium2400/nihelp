function limitation(varargin)
%% PRIVATE HELPER ONLY: called by ylimitation and xlimitation 
% func is used only to vary between xlim/ylim/zlim

%% Read inputs
[ax, args] = axescheck(varargin{:});
if isempty(ax); ax = gca; end

ip = inputParser;
addOptional(ip, 'lims', [], @(x) isa(x, 'double') && (numel(x) == 0 || numel(x) == 2) );
addParameter(ip, 'func', [], @(f) isequal(f, @xlim) || isequal(f, @ylim) || isequal(f, @zlim) ...
    || isequal(f, @clim) || isequal(f, @caxis)); %#ok<CAXIS> 
addParameter(ip, 'max', [], @(x) isa(x, 'double') && (numel(x) == 0 || numel(x) == 1) );
addParameter(ip, 'min', [], @(x) isa(x, 'double') && (numel(x) == 0 || numel(x) == 1) );

parse(ip, args{:});
f = ip.Results.func; 
if isempty(f) 
    error('This is a private helper function. Use xlimitation, ylimitation, zlimitation, or climitation.'); 
end


%% See what limits user has specified
% Either as a pair [min max], or min/max individually
iprmin = ip.Results.min;
iprmax = ip.Results.max;

if ~isempty(ip.Results.lims)
    iprmin = ip.Results.lims(1);
    iprmax = ip.Results.lims(2);
end


%% Set lims
l = f(ax); if ~isempty(iprmax) && iprmax > l(2); f(ax, [l(1), iprmax]); end
l = f(ax); if ~isempty(iprmin) && iprmin < l(1); f(ax, [iprmin, l(2)]); end


end


