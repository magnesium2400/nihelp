function tl = plotModes(s, varargin)

%% Parse inputs
ip = inputParser; 
ip.addOptional('modesq', [], @isnumeric);
ip.addParameter('verticesName', 'vertices', @(x) ischar(x) || isStringScalar(x)); 
ip.addParameter('facesName', 'faces', @(x) ischar(x) || isStringScalar(x)); 
ip.addParameter('evecsName', 'evecs', @(x) ischar(x) || isStringScalar(x)); 
ip.addParameter('evalsName', 'evals', @(x) ischar(x) || isStringScalar(x)); 
ip.parse(varargin{:});

verts = s.(ip.Results.verticesName);   
faces = s.(ip.Results.facesName);   
evecs = s.(ip.Results.evecsName);   
evals = s.(ip.Results.evalsName);   

modesq = ip.Results.modesq; 
if nargin < 2 || isempty(modesq); modesq = 1:width(evecs); 
elseif isscalar(modesq) && (modesq<0); modesq = round(linspace(1, width(evecs), -modesq)); end   


%% Plot
if width(faces) == 3
    [~,~,tl] = plotBrain(verts, faces, [], evecs(:,modesq), 'colorbarOn', 1, 'colormap', @bluewhitered_mg);
elseif width(faces) == 4
    tl = multiplot(evecs(:, modesq), @(x) scat3(verts, [], x, 'filled'), @() axis('equal', 'tight', 'off')); 
    tlfunc(tl, @(ax) colormap(ax, bluewhitered_mg()), 'axnone'); 
end


%% Titles
for ii = 1:length(modesq)
    ax = nexttile(tl, ii); 
    title(ax, sprintf("Mode %i", modesq(ii)));
    subtitle(ax, sprintf("%s = %.4f", '\lambda', evals(modesq(ii))));
end


end