function filepath = fetch_atlas(atlas, density, hemi, key, varargin)


%% This function requires NEUROMAPS_DATA environment variable to be set
neuromapsPath = getenv('NEUROMAPS_DATA');
if isempty(neuromapsPath); error('Please set $NEUROMAPS_DATA using `setenv`'); end


%% Parse inputs
p = inputParser;

addRequired(p, 'atlas',     @(x) ischar(x) || isStringScalar(x));
addRequired(p, 'density',   @(x) ischar(x) || isStringScalar(x));
addRequired(p, 'hemi',      @(x) ischar(x) || isStringScalar(x));
addRequired(p, 'key',       @(x) ischar(x) || isStringScalar(x));

addParameter(p, 'desc',  '', @(x) ischar(x) || isStringScalar(x));
addParameter(p, 'space', '', @(x) ischar(x) || isStringScalar(x));

parse(p, atlas, density, hemi, key, varargin{:});

atlas   = p.Results.atlas;
density = p.Results.density;
hemi    = p.Results.hemi;
key     = p.Results.key;
desc    = p.Results.desc;
space   = p.Results.space;


%% Collect other required information
switch space
    case ''
        spaceString = ''; 
    otherwise
        spaceString = sprintf('_space-%s', space); 
end

switch desc
    case {'sulc', 'vaavg'}
        giftiType = 'shape';
        descString = sprintf('_desc-%s', desc); 
    case 'nomedialwall'
        giftiType = 'label';
        key = 'dparc'; 
        descString = sprintf('_desc-%s', desc); 
    otherwise
        giftiType = 'surf'; 
        descString = ''; 
end

filename = sprintf('tpl-%s%s_den-%s_hemi-%s%s_%s.%s.gii', ...
    atlas, spaceString, density, hemi, descString, key, giftiType);

filepath = char(fullfile(neuromapsPath, 'atlases', atlas, filename));

if ~exist(filepath, 'file'); warning('File not found'); end

end
