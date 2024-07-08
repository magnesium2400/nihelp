function slicevol(xyz, dim, data, edges)


if nargin < 2 || isempty(dim); dim = +1; end
if nargin < 3 || isempty(data); data = xyz(:, abs(dim))*sign(dim); end
if nargin < 4 || isempty(edges); edges = floor(min(xyz(:,abs(dim)))):ceil(max(xyz(:,abs(dim)))); 
elseif isscalar(edges); edges = linspace((min(xyz(:,abs(dim)))),(max(xyz(:,abs(dim)))),edges+1); end


videofig(length(edges)-1, @(n) redraw(xyz, dim, data, edges, n)); 

    function redraw(xyz, dim, data, edges, n)
        m = (xyz(:, dim) >= edges(n)) & (xyz(:, dim) <= edges(n+1)); 
        scat3(xyz(m,:), [], data(m), 'filled'); 
        
        axis equal off; 
        clim([min(data), max(data)]);
        mm = @(n) [min(xyz(:,n)), max(xyz(:,n))];
        xlim(mm(1)); ylim(mm(2)); zlim(mm(3)); 

        switch dim
            case +1; viewh('l'); 
            case -1; viewh('r'); 
            case +2; viewh('p'); 
            case -2; viewh('a'); 
            case +3; viewh('i'); 
            case -3; viewh('s'); 
        end

        % view(2); 
    end


end
