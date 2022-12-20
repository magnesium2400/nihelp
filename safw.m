%% set all figure width, default 524
function safw(x)
if nargin < 1
    safw(524); 
    return
end

h = findobj('Type','figure'); 
for ii = 1:length(h); figure(h(ii)); scfw(x); end

end