function tl = plotModes(s, modesq)

if nargin < 2 || isempty(modesq); modesq = 1:width(s.evecs); 
elseif isscalar(modesq) && (modesq<0); modesq = round(linspace(1, width(s.evecs), -modesq)); end   

if width(s.faces) == 3
    [~,~,tl] = plotBrain(s.vertices, s.faces, [], s.evecs(:,modesq), 'colorbarOn', 1, 'colormap', @bluewhitered_mg);
elseif width(s.faces) == 4
    tl = multiplot(s.evecs(:, modesq), @(x) scat3(s.vertices, [], x, 'filled'), @() axis('equal', 'tight', 'off')); 
    tlfunc(tl, @(ax) colormap(ax, bluewhitered_mg()), 'axnone'); 
end

for ii = 1:length(modesq)
    ax = nexttile(tl, ii); 
    title(ax, sprintf("Mode %i", modesq(ii)));
    subtitle(ax, sprintf("%s = %.4f", '\lambda', s.evals(modesq(ii))));
end

end