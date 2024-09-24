function [f,b] = adj2tri(a)
%% ADJ2TRI Generates triangulation from adjacency matrix
%% Usage notes
% * Only supports single component meshes
% * If the mesh is poorly conditioned - in particular, if there is a triangle of
% vertices that surround 1 or more vertices (especially near the boundary) - the
% algorithm implemented here may fail (a lot of the complexities of this code
% are already trying to correct for this)
%
%
%% Timing
%  | Vertices | Faces | Time (s) | 
%  | :------: | :---: | :------: |
%  | 400      | 800   | 0.0416   |
%  | 3600     | 7200  | 0.3062   |
%  | 10000    | 20000 | 1.6139   |
%  | 19200    | 39200 | 6.2472   |
%  | 32400    | 64800 | 21.0001  |
%
%
%% Examples
% See `adj2tri_test.m` for examples
%
%
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


%% Prelims
a = sparse(logical(a));
if ~issymmetric(a)
    error('Input is not symmetric');
end
if any(diag(a))
    warning('Removing self-connections and proceeding');
    a(1:height(a)+1:end) = false;
end

a2 = (+a)^2;                        % Two step neighbours
[x,y] = find(a);                    % List of edges
[b(:,1),b(:,2)] = find(a & a2<2);   % Boundary
f = nan(height(x)/2-height(a),3);   % Estimate number of faces (refined later)


%% Potentially dodgy edges
% start by finding edges which are on the boundary and still have two neighbours
m = a2(a)==2 & ismember(x,b(:)) & ismember(y,b(:));
d = sparse([x(m);y(m)], [y(m);x(m)], true, height(a), width(a)); 
d = d | (a & (a2~=2)); % add edges which are one step away but not two
clear m


%% Find first two faces (that will share an edge)
% All 5 edges shared between the two faces should be an edge of exactly two triangles
for ii = 1:height(x)
    % Skip edge if either node on boundary
    if any(ismember( [x(ii),y(ii)] , b(:) )); continue; end 
    g = find( a(:,x(ii)) & a(:,y(ii)) );
    % Check all five edges between faces
    if numel(g)==2 && a2(x(ii),y(ii))==2 &&...
            a2(x(ii),g(1))==2 && a2(y(ii),g(1))==2 &&...
            a2(x(ii),g(2))==2 && a2(y(ii),g(2))==2
        % Add the faces and remove edge from further consideration
        f(1:2,:) = [x(ii), y(ii), g(1); y(ii), x(ii), g(2)];
        a(x(ii),y(ii)) = false; %#ok<SPRIX>
        a(y(ii),x(ii)) = false; %#ok<SPRIX>
        break;
    end
end

if isnan(f(1)); error('Unable to find any faces'); end


%% Breadth first search over each edge

flower = 1; fupper = 3; % upper and lower bounds for which faces to check

while nnz(a)
    if flower == fupper; break; end % no new faces added on previous iteration
    temp = f(flower:fupper-1,:);
    flower = fupper;                % for next iteration;
    e = [temp(:), reshape(temp(:,[2 3 1]),[],1)];
    e = unique(e, 'rows');          % edges for consideration in current iter

    % Iterate over all edges
    for ii = 1:height(e)
        e1=e(ii,1); e2=e(ii,2);
        % If the edge has not already been analysed
        if a(e1,e2)
            n = a(:,e1) & a(:,e2);
            % If it has one remaining neighbour (well conditioned)
            if nnz(n) == 1
                f(fupper,:) = [e1, find(n), e2];    % add that face
                fupper = fupper+1; 
                a(e1,e2) = false; a(e2,e1) = false; % and remove that edge
            % If it has more than one remaining neighbour
            elseif nnz(n) > 1       
                for jj = find(n(:)')                % check the neighbours
                    if ~(d(e1,jj) && d(e2,jj))      % proceed if not dodgy
                        f(fupper,:) = [e1, jj, e2];
                        fupper = fupper+1; 
                        a(e1,e2) = false; a(e2,e1) = false;
                    end
                end
            end
        end
    end

end

f = f(1:fupper-1,:); 

end


