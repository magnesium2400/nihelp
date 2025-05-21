function fd = finiteDifference(varargin)
%% Syntax
%  fd = finiteDifference(y); 
%  fd = finiteDifference(x,y); 
%  fd = finiteDifference(x,y,dim); 
%  fd = finiteDifference([],y); 
%  fd = finiteDifference([],y,dim); 
%  fd = finiteDifference(___,Name,Value); 
%
%


%% Parse inputs
ip = inputParser; 
ip.addRequired('x'); 
ip.addOptional('y', []); 

ip.addOptional('dim', 1, @isPositiveIntegerValuedNumeric); 
ip.addParameter('method', 'central', @(x) ismember(x, ["central", "forward", "backward"])); 
ip.addParameter('includeEndpoints', false, @islogical); 
ip.parse(varargin{:}); 

x = ip.Results.x; 
y = ip.Results.y; 
dim = ip.Results.dim; 
method = ip.Results.method; 
includeEndpoints = ip.Results.includeEndpoints; 


%% Reformat inputs

% if dim is specified (x must be specified, but could be empty)
if ~ipiud(ip, 'dim') 
    if ~isempty(x) % if x non-empty, check that x and y match in that dimension
        assert(size(x,dim) == size(y, dim)); 
        [x,y] = impex(x,y); 
    else % otherwise, generate x in the appropriate dimension
        x = (1:size(y, dim))';
        if dim~=1; x = permute(x, (dim:-1:1)); end
        x = impex(x,y); 
    end
end

% dim not suppplied
if ipiud(ip, 'dim')
    if ~ipiud(ip, 'y') & ~isempty(x) % if x and y both specified
        if isvector(x) && isvector(y)
            assert(numel(x) == numel(y));
            x = reshape(x, size(y)); 
            dim = firstdim(y);
        elseif isvector(x) % && ~isvector(y)
            x = x(:); 
            dim = find(numel(x) == size(y), 1, 'first'); 
            if dim~=1; x = permute(x, (dim:-1:1)); end
            x = impex(x,y);
        elseif isvector(y) % && ~isvector(x)
            y = y(:); 
            dim = find(numel(y) == size(x), 1, 'first'); 
            if dim~=1; y = permute(y, (dim:-1:1)); end
            y = impex(y,x);
        else
            assert(areCompatible(x,y)); 
            [x,y] = impex(x,y); 
            dim = firstdim(x); 
        end

    else % either x or y unspecified
        if ipiud(ip, 'y')
            y = x;
            x = [];
        end
        if isempty(x)
            dim = firstdim(y);
            x = (1:size(y, dim))';
            if dim~=1; x = permute(x, (dim:-1:1)); end
            x = impex(x,y);
        end
    end
end


%% Calculations

diffs = diff(y,1,dim)./diff(x,1,dim); 
dfirst = sliceDim(diffs, dim, 1, 0); 
dlast = sliceDim(diffs, dim, size(diffs, dim), 0); 

ny = size(y, dim); 
nx = size(x, dim); 



% first = (y(2)-y(1)./x(2)-x(1)); 
% last = (y(end)-y(end-1))./(x(end)-x(end-1)); 

switch method
    case 'central'
        ya = sliceDim(y, dim, 1:ny-2, 0);
        yb = sliceDim(y, dim, 3:ny,   0);
        xa = sliceDim(x, dim, 1:nx-2, 0);
        xb = sliceDim(x, dim, 3:nx  , 0);
        fd = (yb-ya)./(xb-xa); 
        if includeEndpoints; fd = cat(dim, dfirst, fd, dlast); end
        % out = (y(3:end)-y(1:end-2))./(x(3:end)-x(1:end-2)); 
        % if includeEndpoints; out = [first, out, last]; end
    otherwise
        ya = sliceDim(y, dim, 1:ny-1, 0);
        yb = sliceDim(y, dim, 2:ny,   0);
        xa = sliceDim(x, dim, 1:nx-1, 0);
        xb = sliceDim(x, dim, 2:nx  , 0);
        fd = (yb-ya)./(xb-xa); 
        if includeEndpoints & strcmp(method, 'forward')
            fd = cat(dim, fd, dlast);
        else
            fd = cat(dim, dfirst, fd);
        end

    % case 'forward'
    %     out = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1));
    %     if includeEndpoints; out = [first, out]; end
    % case 'backward'
    %     out = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1));
    %     if includeEndpoints; out = [out, last]; end
end

end

