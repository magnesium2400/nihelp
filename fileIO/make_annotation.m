function [vertices, label, ct] = make_annotation(rois, varargin)
%% Examples
%   [vertices, label, ct] = make_annotation(randi(10,100,1));
%   [vertices, label, ct] = make_annotation(randi(10,100,1)-1);
%   [vertices, label, ct] = make_annotation(randi(10,100,1), 'cmap', @(x) jet(x)*255);
%   [vertices, label, ct] = make_annotation(randi(10,100,1), 'orig_tab', 'cool_rois');
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


%% Prelims
n = max(rois)+1;
ip = inputParser;
ip.addRequired('rois', @(x) isnumeric(x) && (size(x,2)==1));
ip.addParameter('cmap', @(x) parula(x)*255, @(x) (isnumeric(x) && size(x,2)==3) || isa(x,'function_handle') );
ip.addParameter('orig_tab', ['my_rois_',char(datetime('now','Format','yyMMddhhmmss'))] , @(x) isStringScalar(x) || ischar(x));
ip.addParameter('flag', zeros(n,1), @(x) isnumeric(x) && size(x,1) == n && size(x,2) == 1 );

ip.parse(rois, varargin{:});
rois = ip.Results.rois;
cmap = ip.Results.cmap;
orig_tab = char(ip.Results.orig_tab);


%% Calculations for ct
ct.numEntries = n; 
ct.orig_tab = orig_tab;
ct.struct_names = arrayfun(@(x) char(orig_tab + "_" + x), 1:n, 'UniformOutput',false).';

ct.table = zeros(n, 5);

% generate rgb values for n-1 terms, and then add white for rois labelled 0
if (isnumeric(cmap))
    rgb = interp1( (0:size(cmap,1)-1)/(size(cmap,1)-1) , cmap , (0:(n-2))/(n-2) );
else % is function handle
    rgb = cmap(n-1);
end 
rgb = [1,1,1;round(rgb)]; % standard for rois labelled 0

assert(all(rgb>=0,'all') && all(rgb<=255,'all'))

ct.table(:,1:3) = rgb;
ct.table(:,4) = ip.Results.flag;
ct.table(:,5) = sum( ct.table(:,1:4) .* (256).^(0:3)    , 2 );


%%
vertices = (1:size(rois, 1)).'-1;
label = ct.table(rois+1,5);


end
