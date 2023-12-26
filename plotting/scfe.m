function scfe(f)
%% Set Current Figure to have white background
if nargin < 1; f = gcf; end
set(f, 'Color', [1 1 1]);
end