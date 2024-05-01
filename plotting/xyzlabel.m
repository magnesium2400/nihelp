function xyzlabel(xl,yl,zl)

if nargin < 1; xlabel('x'); else; xlabel(xl); end
if nargin < 2; ylabel('y'); else; ylabel(yl); end
if nargin < 3; zlabel('z'); else; zlabel(zl); end

end

