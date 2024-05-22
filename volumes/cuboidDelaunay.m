function [faces, verts] = cuboidDelaunay(V)
%% CUBOIDDELAUNAY Marching-cubes like algorithm to generate tetrahedral mesh from volume
%% Examples
%   cuboidDelaunay(ones(5,5,5));
%   V = ones(5,5,5); V(86:end) = 0; [f,v] = cuboidDelaunay(V); figure; tetramesh(f,v); 
%   V = xyz2vol(solidTorusMesh(10)+50,[],0); [f,v] = cuboidDelaunay(V); figure; tetramesh(f,v);
% 
% 
%% TODO
% * plenty of options to speed this up if desired e.g. find status of each
% vertex and expand to faces at end, using parfor etc
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


%% Setup
% Cache delaunay data for each configuration of vertices
persistent cache
if isempty(cache)
    tmp = arrayfun(@(x) 0:1, 1:8, 'uni', 0);
    tmp = table2array(combinations(tmp{:})==1);
    cache = arrayfun(@(ii) makeDelaunayCase(tmp(ii,:)), 1:256, 'uni', 0);
end

% Helper function for indexing into cache: converts binary value to decimal
dec = @(idx) (2.^(7:-1:0))*idx;


%% Prelims
mask = logical(V);
V(mask) = 1:nnz(V);                                  % set value of each vertex to its ID
verts = vol2xyz(V, mask);                            % get xyz-coordinates of each vertex

V2 = imdilate(mask, ones(3,3,3));                    % these are the vertices to search
V2(end,:,:) = 0; V2(:,end,:) = 0; V2(:,:,end) = 0;   % exclude end of each dimension
[x,y,z] = ind2sub(size(V2), find(V2));               % convert to subscript IDs  

clear mask V2; 


%% Calc faces
f = cell(length(x),1); 
for ii = 1:length(x)                                 % for each vertex in the inflated mask
    curr = V(x(ii)+[0,1], y(ii)+[0,1], z(ii)+[0,1]); % find the neighbor-status of the cuboid it indexes
    f{ii} = curr(cache{ dec(logical(curr(:)))+1 });  % read the cache to see what faces that cuboid should have                
end
faces = cell2mat(f);                                                 


end


function faces = makeDelaunayCase(v)
faces = [];
try
    [x,y,z] = ind2sub([2 2 2], 1:8);
    faces = delaunay(x(v), y(v), z(v));
    idx = find(v);
    faces = idx(faces);
catch
end
end
