function out = colorText(str, col)
if nargin < 2; col = [0.5 0.5 0.5]; end
out = sprintf('{\\color[rgb]{%s}%s}', num2str(col), str);
end
