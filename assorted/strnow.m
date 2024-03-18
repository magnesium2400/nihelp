function out = strnow(format)
if nargin < 1; format = 'yyMMddHHmmss'; end
out = string(datetime('now','Format', format));
end
