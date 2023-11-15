function scfg(f)
%% Set Current Figure to have default Gray background
if nargin < 1; f = gcf; end
set(f, 'Color', [240 240 240]/255);
end