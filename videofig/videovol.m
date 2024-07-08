function videovol(xyz, dim, data, edges)

if nargin < 2 || isempty(dim); dim = +1; end
if nargin < 3 || isempty(data); data = xyz(:, abs(dim))*sign(dim); end
if nargin < 4 || isempty(edges); edges = floor(min(xyz(:,abs(dim)))):ceil(max(xyz(:,abs(dim)))); 
elseif isscalar(edges); edges = linspace((min(xyz(:,abs(dim)))),(max(xyz(:,abs(dim)))),edges); end



videofig(length(edges), @(n) redraw(xyz, dim, data, edges, n)); 

    function redraw(xyz, dim, data, edges, n)
        m = xyz(:, dim) <= edges(n); 
        scat3(xyz(m,:), [], data(m)); 
        axis equal off; 
        mm = @(n) [min(xyz(:,n)), max(xyz(:,n))];
        xlim(mm(1)); ylim(mm(2)); zlim(mm(3)); 
    end


end
