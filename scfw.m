%% set current figure width, default 524
function scfw(x)
if nargin < 1
    scfw(524); 
    return
end
set(gcf,'Position',get(gcf,'Position').*[1,1,0,1]+[0,0,x,0])
end