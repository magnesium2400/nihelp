function out = coincidentNeighbours(verts, faces)
%% COINCIDENTNEIGHBOURS Find sets of neighbouring vertices with the same coordinates
%% Examples
% See `examples_meshes_coincidence.mlx`
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


%% Get adjacency matrix
A = ...
    sparse( ...
        reshape(faces            , [], 1), ...
        reshape(faces(:, [2 3 1]), [], 1), ...
        1, max(faces, [], 'all'), max(faces, [], 'all') ...
    );
A = logical(triu(A + A',1));


%% Computations
out = {}; idx = 1:size(A); ii = length(idx);

while ii > 0                                   % start at top, iterate down
    Nii = A(:,idx(ii));                        % get current neighbours
    d = pdist2( verts(idx(ii),:) , verts(Nii,:) );
    if any(d==0)                               % if distance to any neighbour(s) is 0
        c = find(Nii);
        c = c(d==0);
        out = [out(:); {[idx(ii), flip(c)']}]; % store ids of these neighbours
        idx(c) = [];                           % remove from list
        ii = ii - length(c);                   % keep incrementing down
    end
    ii = ii-1;
end


end


