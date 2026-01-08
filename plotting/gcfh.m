function [out, units] = gcfh(fig)
if nargin < 1; fig = gcf(); end
p = get(fig, 'Position'); 
out = p(4); 
units = get(fig, 'Units'); 
end
