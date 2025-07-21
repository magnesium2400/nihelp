function [fd,xi] = finiteDifference(varargin)
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

ip.addOptional('dim', 1, @(x) isscalar(x) & (x>0) & (~mod(x,1))); 
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
            dim = firstdim(y); 
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

fd = diff(y,1,dim)./diff(x,1,dim); 
dfirst = sliceDim(fd, dim, 1, 0); 
dlast  = sliceDim(fd, dim, size(fd, dim), 0); 

nx = size(x, dim); 
ny = size(y, dim); 

% Central points
switch method
    case 'forward'
        xi = sliceDim(x, dim, 1:nx-1, 0); 
    case 'backward'
        xi = sliceDim(x, dim, 2:nx,   0); 
    case 'central'
        xi = sliceDim(x, dim, 2:nx-1, 0);
        ya = sliceDim(y, dim, 1:ny-2, 0);
        yb = sliceDim(y, dim, 3:ny,   0);
        xa = sliceDim(x, dim, 1:nx-2, 0);
        xb = sliceDim(x, dim, 3:nx  , 0);
        fd = (yb-ya)./(xb-xa); 
end

% Add endpoints if needed
if includeEndpoints
    xi = x;
    switch method
        case 'forward'
            fd = cat(dim, fd, dlast);
        case 'backward'
            fd = cat(dim, dfirst, fd);
        case 'central'
            fd = cat(dim, dfirst, fd, dlast);
    end
end

end

