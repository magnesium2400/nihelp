function [out, units] = gcfw(fig)
if nargin < 1; fig = gcf(); end
p = get(fig, 'Position'); 
out = p(3); 
units = get(fig, 'Units'); 
end
