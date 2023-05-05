function out = multi_cmap(initial, color1, middle, color2, final, varargin)
%%MULTICMAP makes divergins colormaps using make_cmap and rgb


% Mehul Gajwani
% Monash University, 2023
%% Prelims
ip = inputParser;
addRequired(ip, 'initial');
addRequired(ip, 'color1');
addRequired(ip, 'middle');
addRequired(ip, 'color2');
addRequired(ip, 'final');

addParameter(ip, 'lightCentre', []);
addParameter(ip, 'darkCentre', []);
addParameter(ip, 'defaultCut', 30);
addParameter(ip, 'firstCut', {});
addParameter(ip, 'secondCut', {});
addParameter(ip, 'nInterpPoints', 250);

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
nInterpPoints       = ip.Results.nInterpPoints;


%% Check inputs
newWarning = warning('Unusual inputs provided, may result in unexpected behaviour');
if (initial == middle); initial = middle - eps; newWarning; end %#ok<VUNUS> 
if (final == middle);   final = middle + eps;   newWarning; end %#ok<VUNUS> 
if ((initial > middle) || (middle > final));    newWarning; end %#ok<VUNUS> 


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


%% Make and output maps
cmap1 = make_cmap(color1, nInterpPoints*(middle-initial)/(final-initial), firstCut{:});
cmap2 = make_cmap(color2, nInterpPoints*(final - middle)/(final-initial), secondCut{:});

if darkCentre; out = [flipud(cmap1); (cmap2)]; 
else; out = [(cmap1); flipud(cmap2)]; end

end
