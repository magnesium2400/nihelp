function [verts, faces] = cuboidSurface(a,b,c)
%% CUBOIDSURFACE Generates regular square mesh on surface of rectangular prism
%% Examples
%   [v,f] = cuboidSurface; figure; trimesh(f, v(:,1), v(:,2), v(:,3), 'FaceColor', 'none');
%   [v,f] = cuboidSurface(3,4,5); figure; trimesh(f, v(:,1), v(:,2), v(:,3), 'FaceColor', 'none'); axis equal;
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


if nargin < 1 || isempty(a); a = 20; end
if nargin < 2 || isempty(b); b = a; end
if nargin < 3 || isempty(c); c = (a+b)/2; end


%%
[x,y,z] = ndgrid(1:a,1:b,1:c);
verts = [x(:), y(:), z(:)];
verts = verts(any( (verts==[1 1 1]) | (verts==[a b c]) ,2),:);

% if nargout < 2; return; end

dims = [-1 1 2 -2 -3 3]; % use negative to reorient faces
funcs = {@(x) x(:,1) == 1, @(x) x(:,1) == a, ...
    @(x) x(:,2) == 1, @(x) x(:,2) == b, ...
    @(x) x(:,3) == 1, @(x) x(:,3) == c};

faces = [];

for ii = 1:length(funcs)
    func = funcs{ii};
    mask = func(verts);
    d = delaunay(verts( mask , setdiff(1:3,abs(dims(ii))) ));

    idx = find(mask);
    if dims(ii) < 0
        faces = [faces; idx(d(:,[1 3 2]))]; %#ok<AGROW>
    else
        faces = [faces; idx(d)]; %#ok<AGROW>
    end
end







end


