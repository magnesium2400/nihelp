%% set all figure width, default 1024
function safh(x)
if nargin < 1
    safh(1024); 
    return
end

h = findobj('Type','figure'); 
for ii = 1:length(h); figure(h(ii)); scfh(x); end

end