%% set current figure height, default 420
function scfh(x)
if nargin < 1; x = 420; end
set(gcf, 'Position',...
    get(gcf,'Position')*[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 1 0 0] + [0,-x,0,x]);
end
