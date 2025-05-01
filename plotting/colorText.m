function out = colorText(str, col)
if nargin < 2; col = [0.5 0.5 0.5]; end
if iscell(str); out = cellfun(@(x) colorText(x,col), str, 'Uni', 0);
else; out = sprintf('{\\color[rgb]{%s}%s}', num2str(col), str); end
end
