function out = faceOrientation(faces)
%% FACEORIENTATION Finds the relative orientation of each face in triangulation
%% Examples
%   v=rand(100,2); f=delaunay(v); fo = faceOrientation(f); assert(all(fo==1)); 
% See `faceOrientation_test.m` for more examples. 
% 
% 
%% Usage Notes
% For an input triangulation of `f` faces, the output will be an `f x 1` vector
% containing positive and negative integer values. Each integer is associated
% with one component. Positive values indicate that that face has the same
% relative orientation as the 'first' face in that component (where first means
% appearing first in the input matrix); negative values indicate the opposite
% orientation. 
%
%
%% %% Timings
%  | Faces  | Time (s) |
%  | :---:  | :------: |
%  | 20     | 0.001240 |
%  | 80     | 0.002013 |
%  | 320    | 0.006903 |
%  | 1280   | 0.025448 |
%  | 5120   | 0.101284 |
%  | 20480  | 0.384685 |
%  | 81920  | 1.759828 |
%  | 327680 | 7.711887 |
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

nf = height(faces); 
nv = max(faces(:)); 

out = nan(nf, 1); 
done = false(nf, 1); 
nComp = 1; 

tr = triangulation(faces, (1:nv)' + [0 0 0]); 

perm = @(x) x([1 2 3; 2 3 1; 3 1 2]);

% Checks each face, but ends up iterating over each component
for ii = 1:nf
    if done(ii); continue; end

    out(ii) = nComp; 
    done(ii) = true; 
    nidx = rmmissing(neighbors(tr, ii)); 
    parent = ii*ones(size(nidx)); 

    % Breadth first search
    % Starts at the 'first' face in each component and iteratively searches over
    % its neighbours
    while ~isempty(nidx) 
        curr = nidx(1); 
        
        if done(curr) || isnan(curr)
            nidx(1) = [];
            parent(1) = [];
            continue;
        end
        
        sameOrientation = max(sum( perm(faces(parent(1),:)) == faces(curr,:) , 2 )) == 1;
        if sameOrientation; out(curr) = out(parent(1)); 
        else;               out(curr) = -1*out(parent(1));  end
        
        done(curr) = true;
        nidx(1) = []; 
        parent(1) = [];

        currN = rmmissing(neighbors(tr, curr));
        currN = currN .* ~done(currN)'; 
        nidx = [nidx, nonzeros(currN)']; %#ok<AGROW>
        parent = [parent, curr*ones(1, nnz(currN))]; %#ok<AGROW>
    end

    nComp = nComp + 1; 

end


end

