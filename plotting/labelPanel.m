function labelPanel(varargin)

[ax, args] = axescheck(varargin{:});
if isempty(ax); ax = gca; end

fig = gcf;
if isprop(fig, 'LabelPanelCounter')
    set(fig, 'LabelPanelCounter', fig.LabelPanelCounter+1);
else
    addprop(fig, 'LabelPanelCounter');
    fig.LabelPanelCounter = 1;
end



if isempty(args) % label not supplied
    panelLabel =  char(64+fig.LabelPanelCounter);
else % label supplied
    panelLabel = args{1};
end

t = ax.Title;
if isempty(t.String)
    set(t, 'String', panelLabel);
else
    set(t, 'String', sprintf('%s | %s', num2str(panelLabel), t.String));
end

ax.TitleHorizontalAlignment = 'left';


end

% % % % %
% % % % % [ax, args] = axescheck(varargin{:});
% % % % % if isempty(ax); ax = gca; end
% % % % %
% % % % % ip = inputParser;
% % % % % ip.addRequired('panelLabel', @(x) ischar(x) || isStringScalar(x));
% % % % % ip.addParameter('Position', []);
% % % % % ip.addParameter('subtitleOptions', {'FontWeight', 'bold', 'FontSize', 20});
% % % % % ip.parse(args{:});
% % % % %
% % % % %
% % % % %
% % % % % t = ax.Title;
% % % % % tPos = t.Position;
% % % % %
% % % % %
% % % % % st = subtitle(ip.Results.panelLabel, ip.Results.subtitleOptions{:});
% % % % % if isempty(ip.Results.Position)
% % % % %     st.Position = [-0.1, tPos(2), tPos(3)];
% % % % % else
% % % % %     st.Position = ip.Results.Position;
% % % % % end
% % % % %
