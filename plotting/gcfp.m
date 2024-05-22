function out = gcfp(f)
if nargin < 1; f = gcf; end
out = "'Position', [" + strjoin(string(f.Position),",") + "]";
end