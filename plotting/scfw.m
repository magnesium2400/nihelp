%% set current figure width, default 560
function scfw(x)
if nargin < 1; x = 560; end
set(gcf, 'Position',...
    get(gcf,'Position')*[1 0 0 0; 0 1 0 0; 1 0 0 0; 0 0 0 1] + [-x,0 x,0]);
end