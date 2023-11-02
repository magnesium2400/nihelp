function s = plotStreamline(verts, varargin)
%% Plots a streamline 
% size(verts)=[nPoints,3] (xyz coordinates of streamline)


%% Prelims
ip = inputParser;
ip.addRequired('verts');
ip.addParameter('w', {});
ip.addParameter('scaleN', [.2 20]);
ip.addParameter('surfaceOptions', struct(...
    'EdgeColor', 'none', ...
    'EdgeLighting', 'flat', ...
    'FaceLighting', 'gouraud' ...
    ));
ip.addParameter('color', []);

ip.parse(verts, varargin{:});
ipr = ip.Results;


%%
s = streamtube({ipr.verts}, ipr.w, ipr.scaleN);
set(s, ipr.surfaceOptions);
material dull;


%% Color
if isempty(ipr.color)
    col = abs(verts(end,:) - verts(1,:));
    set(s, 'FaceColor', col/max(col));
else
    set(s, 'FaceColor', ipr.FaceColor);
end



end