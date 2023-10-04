function out = multi_cmap(initial, color1, middle, color2, final, varargin)
%%MULTICMAP makes diverging colormaps using make_cmap and rgb


% examples
% n = 10; figure; tiledlayout('flow'); for ii = 1:(n+3); ax=nexttile(); imagesc(magic(n) - (ii-2)*n); cmap=multi_cmap('bluewhitered'); colormap(ax, cmap); colorbar; end;


% Mehul Gajwani
% Monash University, 2023

%% Special syntax (which takes precedence over inputParser)
if nargin == 1
    if isequal(initial, 'bluewhitered')
        out = multi_cmap(min(clim), [0 0 1], 0, [1 0 0], max(clim), ...
            'autoscaleColors', true);
        return;
    end
elseif nargin == 2
    out = multi_cmap(min(clim), initial, 0, color1, max(clim), ...
        'autoscaleColors', true);
    return;
end


%% Prelims
ip = inputParser;
addRequired(ip, 'initial');
addRequired(ip, 'color1');
addRequired(ip, 'middle');
addRequired(ip, 'color2');
addRequired(ip, 'final');

addParameter(ip, 'defaultCut', 25);
addParameter(ip, 'lightCentre', []);
addParameter(ip, 'darkCentre', []);
addParameter(ip, 'firstCut', {});
addParameter(ip, 'secondCut', {});
addParameter(ip, 'autoscaleColors', false);
addParameter(ip, 'nInterpPoints', 256);

parse(ip, initial, color1, middle, color2, final, varargin{:});
color1              = ip.Results.color1;
color2              = ip.Results.color2;
initial             = ip.Results.initial;
middle              = ip.Results.middle;
final               = ip.Results.final;
firstCut            = ip.Results.firstCut;
secondCut           = ip.Results.secondCut;
lightCentre         = ip.Results.lightCentre;
darkCentre          = ip.Results.darkCentre;
defaultCut          = ip.Results.defaultCut;
autoscaleColors     = ip.Results.autoscaleColors;
nInterpPoints       = ip.Results.nInterpPoints;


%% Check inputs
% inputMsg = 'Unusual inputs provided, may result in unexpected behaviour';
if (initial == middle); initial = middle - eps; end%warning(inputMsg); end
if (final == middle);   final = middle + eps;   end%warning(inputMsg); end
if ((initial > middle) || (middle > final));    end%warning(inputMsg); end


%% Allow user to specify lightCentre or darkCentre, or use defaults
% note that the rest of the script only uses darkCentre (i.e. lightCentre can
% remain empty)
if isempty(darkCentre) && isempty(lightCentre)
    darkCentre = false;
elseif isempty(darkCentre)
    darkCentre = ~lightCentre;
end


%% Allow use to specify cuts as vectors or cells, or use defaults
if isempty(firstCut)
    if darkCentre; firstCut = {0, defaultCut}; else; firstCut = {defaultCut, 0}; end
    %firstCut = tern(darkCentre, {0, defaultCut}, {defaultCut, 0});
end
if isempty(secondCut)
    if darkCentre; secondCut = {0, defaultCut}; else; secondCut = {defaultCut, 0}; end
    %secondCut = tern(darkCentre, {0, defaultCut}, {defaultCut, 0});
end

if isnumeric(firstCut); firstCut = mat2cell(firstCut(:)); end
if isnumeric(secondCut); secondCut = mat2cell(secondCut(:)); end


%% Override previous if user wants to rescale colors
if autoscaleColors
    if abs(final-middle) >= abs(middle-initial) % second half is larger
        firstCut = {100-(100-defaultCut)*(middle-initial)/(final-middle), 0};
        if darkCentre; firstCut = firstCut([2,1]); end
    else % first half is larger
        secondCut = {100-(100-defaultCut)*(final-middle)/(middle-initial), 0};
        if darkCentre; secondCut = secondCut([2,1]); end
    end
end


%% Make and output maps
cmap1 = make_cmap(color1, nInterpPoints*(middle-initial)/(final-initial), firstCut{:});
cmap2 = make_cmap(color2, nInterpPoints*(final - middle)/(final-initial), secondCut{:});

if darkCentre; out = [flipud(cmap1); (cmap2)];
else; out = [(cmap1); flipud(cmap2)]; end


end
