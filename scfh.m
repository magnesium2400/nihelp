%% set current figure width, default 1024
function scfh(x)
if nargin < 1
    scfh(1024); 
    return
end
set(gcf,'Position',get(gcf,'Position')*[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 1 0 0]+[0,-x,0,x])
end