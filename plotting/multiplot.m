function tl = multiplot(data, varargin)
%% MULTIPLOT Removes boilerplate when plotting in tiledlayout
%% Syntax
%   multiplot(data)
%   multiplot(data,func)
%   multiplot(data,func,otherFuncs)
%   
%   multiplot(_,Name,Value)
%   tl = multiplot(_)
%
%
%% Description
% `multiplot(data)` generates a new `tiledlayout` and creates a 2-D line plot of
% the data in each column of `data` on a new tile. 
% 
% `multiplot(data,func)` creates the plots using the specified function. 
% 
% `multiplot(data,func,otherFuncs)` adds more details to each of the tiles
% generated. The changes apply to all the tiles. 
%   
% `multiplot(_,Name,Value)` specifies more properties using one or more
% name-value arguments. For example, some columns in `data` can be skipped. 
% 
% `tl = multiplot(_)` returns the `tiledlayout` object generated. 
%
%
%% Examples
%   figure; multiplot(rand(20, 5)); 
%   figure; multiplot(rand(20, 5), @plot, {@(x) title(x)}); 
%   figure; multiplot(rand(20, 5), @plot, {@(x) title(x)}, 'dim', 1, 'n', find(rand(20,1)>0.5)'); 
%   figure; multiplot(rand(20, 5), @(x) scatter(2:2:40, x, [], x, 'filled'), {@(x) title(x), @() axis('off'), @colorbar}); 
%   figure; multiplot(rand(20, 20, 5), @imagesc); 
%   figure; multiplot(rand(20, 20, 5), @(x) imagesc(x, [-2 2])); 
%   figure; multiplot(loadmri, @(x) imagesc(flipud(x.')), {@() axis('tight'), @() colormap(gray), @(x) title("y="+x)}, 'dim', 2, 'n', 20:20:120, 'tiledlayoutOptions', {3,2}); 
%   figure; multiplot(randn(4, 4, 4, 4), @plotVolume); 
%   
%   figure; multiplot(5:5:20, @(x)imagesc(magic(x)), @title);
%   figure; multiplot(1:20, @(x)imagesc(magic(x)), @title, 'n', 5:5:20);
%   figure; multiplot(@magic, @imagesc, @title, 'n', 5:5:20);
%   figure; multiplot(@(x) magic(x), @imagesc, @title, 'n', 5:5:20);
%   figure; multiplot(@(x) magic(5*x), @imagesc, @title, 'n', 1:4);
%   figure; multiplot(arrayfun(@magic,5:5:20,'Uniform',0), @imagesc, @title);
%   figure; multiplot(5:5:20, @(x)imagesc(magic(x)), {@title,@labelPanel});
% 
% 
%% Input Arguments
% `data - data to be plotted (matrix)` Data to be plotted, specified as a
% matrix. By default, data will be plotted along the last non-singleton
% dimension of `data` (e.g. each column will be plotted in a 2-dimensional
% matrix, and each slice in a 3-dimensional matrix). This can be changed using
% the `dim` name-value argument (see below). 
% 
% `func - function to use for plotting (@plot (default) | function handle)`
% Plotting function handle. A function with one input that takes in 1 slice of
% `data` as input and makes a plot of it as desired.
% 
% `otherFuncs - other functions to be applied to each tile (cell array of
% function handles)` Each function in this cell array will be applied to each
% tile, after plotting is completed. Each function in this array should take in
% 0 or 1 inputs. If it takes in 1 input, the tile number will be supplied as
% input. Some examples might be `@title` or `@() axis('tight')` or `@(x)
% ylim([-x,x])` - see examples above.
% 
% 
%% %% Name-Value Arguments 
% `tiledlayoutOptions - arguments to pass in when generating tiledlayout (cell
% array)`
% 
% `dim - dimension to traverse when plotting data (positive integer scalar)`
% Dimension to operate along, specified as a positive integer scalar. If you do
% not specify the dimension, then the default is the last array dimension of
% size greater than 1.
% 
% `n - query points (vector)` Slice IDs to plot, specified as a vector of
% positive integers. If you do not specify the query points, then the default is
% all values along the dimension being traversed.
% 
% `Parent - parent container (Figure object | Panel object | Tab object |
% TiledChartLayout object)`
% 
% 
%% Output Arguments
% `tl - tiledlayout that is generated (TiledChartLayout handle)`
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 
%% See Also
% TILEDLAYOUT
% 
%


%% Prelims
ip = inputParser;
ip.addRequired('data', @(x) isnumeric(x) || iscell(x) || isa(x, "function_handle"));
ip.addOptional('func', @plot, @(x) isa(x, 'function_handle'));
ip.addOptional('otherFuncs', {}, @(x) isa(x, 'function_handle') || all(cellfun(@(y) isa(y, 'function_handle'), x)));

ip.addParameter('tiledlayoutOptions', {'flow'}, @iscell);
ip.addParameter('dim', ndims(data)); 
ip.addParameter('n', []); 
ip.addParameter('nPlots', []); 
ip.addParameter('spacing', []); 
ip.addParameter('Parent', gcf); 

ip.parse(data, varargin{:});
data                = ip.Results.data;
func                = ip.Results.func;
otherFuncs          = ip.Results.otherFuncs;
dim                 = ip.Results.dim;
n                   = ip.Results.n;
nPlots              = ip.Results.nPlots;
spacing             = ip.Results.spacing;

if isa(otherFuncs, 'function_handle'); otherFuncs = {otherFuncs}; end

if isempty(n)
    s = sz(data,dim); 
    if ~isempty(nPlots);        n = round(linspace(1, s, nPlots)); 
    elseif ~isempty(spacing);   n = 1:spacing:s; 
    else                        n = 1:s; 
    end
    % if iscell(data);    n = 1:numel(data); 
    % else;               n = 1:size(data, dim); end
end


%% Plotting

tl = tiledlayout(ip.Results.Parent, ip.Results.tiledlayoutOptions{:}); 

for ii = n

    nexttile(tl); 

    if      iscell(data);                   currentData = data{ii};
    elseif  isa(data, 'function_handle');   currentData = data(ii);
    else;                                   currentData = sliceDim(data, dim, ii); 
    end
    func( currentData );

    for jj = 1:length(otherFuncs)
        currFunc = otherFuncs{jj};
        if     nargin(currFunc) == 0;   currFunc(); 
        elseif nargin(currFunc) == 1;   currFunc(ii); 
        elseif nargin(currFunc) == -1;  try currFunc(ii); catch; currFunc(); end
        end
    end

end

end



function out = sz(data,dim)
    if iscell(data);    out = numel(data); 
    else;               out = size(data, dim); end
end


