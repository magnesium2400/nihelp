function [v, f] = doublePatch(v,f,n)
%% DOUBLEPATCH Splits each triangle in surface mesh into 4 congruent triangles
%% Examples
%   [v,f] = doublePatch(eye(3),1:3)
%   [v,f] = doublePatch(eye(3),1:3,2)
%   v = eye(3); f = 1:3; t = @(v,f) trimesh(f,v(:,1),v(:,2),v(:,3)); figure; t(v,f); [v,f] = doublePatch(v,f); hold on; t(v,f);
%   v = eye(3); f = 1:3; t = @(v,f) trimesh(f,v(:,1),v(:,2),v(:,3)); figure; t(v,f); [v,f] = doublePatch(v,f,4); hold on; t(v,f);
%   
%   v = [1 3 0; 1 2 0; 2 2 0; 1 1 0; 2 1 0; 3 1 0]; f = [1 2 3; 2 4 5; 3 2 5; 3 5 6]; [v2,f2] = doublePatch(v,f); figure; patchvfc(v,f,[],'LineStyle', '--', 'FaceAlpha', 0,'LineWidth',2); hold on; patchvfc(v2,f2); axis equal tight; 
%   [v,f] = cuboidSurface(2,3,4); [v2,f2] = doublePatch(v,f); figure; patchvfc(v,f,[],'LineStyle', '--', 'FaceAlpha', 0,'LineWidth',2); hold on; patchvfc(v2,f2); axis equal tight;
%   [v,f] = torusMesh; [v2,f2] = doublePatch(v,f); figure; patchvfc(v,f,[],'LineStyle', '--', 'FaceAlpha', 0,'LineWidth',2); hold on; patchvfc(v2,f2); axis equal tight;
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

if nargin < 3 || isempty(n); n = 1; end

for ii = 1:n
    e = sort([ f(:,[1,2]) ; f(:,[2,3]) ; f(:,[3,1]) ],2); 
    [E, ~, ej] = unique(e,'rows','sorted');
    fn = reshape(ej,[],3)+height(v);
    v = [v; (v(E(:,1),:) + v(E(:,2),:))/2]; %#ok<AGROW>
    f = [fn; [[fn(:,[1,3]); fn(:,[2,1]); fn(:,[3,2])], f(:)]];
end

end

% f = [fn; fn(:,[1,3]), f(:,1); fn(:,[2,1]), f(:,2); fn(:,[3,2]), f(:,3)];
