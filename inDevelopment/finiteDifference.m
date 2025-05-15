function out = finiteDifference(x,y,method,includeEndpoints)

x = x(:)'; 
y = y(:)'; 
if nargin < 3 || isempty(method); method = 'central'; end
if nargin < 4 || isempty(includeEndpoints); includeEndpoints = false; end

first = (y(2)-y(1)./x(2)-x(1)); 
last = (y(end)-y(end-1))./(x(end)-x(end-1)); 

switch method
    case 'central'
        out = (y(3:end)-y(1:end-2))./(x(3:end)-x(1:end-2)); 
        if includeEndpoints; out = [first, out, last]; end
    case 'forward'
        out = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1)); 
        if includeEndpoints; out = [first, out]; end
    case 'backward'
        out = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1)); 
        if includeEndpoints; out = [out, last]; end
end

end

