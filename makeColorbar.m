loc = 'north';

cbartitle = 'Node Strength';

cbarlabels = {'min', 'max'};

cmap = plasma;


%%
figure;
c = colorbar('Location', loc, 'FontSize', 24);
axis off;
colormap(cmap);
c.Ticks = linspace(0, 1, length(cbarlabels));
c.TickLabels = cbarlabels;

if strcmp(loc, "east"); c.Label.Position = [3 0.5 0];
elseif strcmp(loc, "west"); c.Label.Position = [-3 0.5 0]; scfw(1500); scfh(420);
elseif strcmp(loc, "south"); c.Label.Position = [0.5 -2 0]; 
elseif strcmp(loc, "north"); c.Label.Position = [0.5 3.5 0]; 
end

c.Label.String = cbartitle;
c.Label.FontSize = 30;










