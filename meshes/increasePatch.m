function [v2, f2] = increasePatch(v,f)
%% INCREASE PATCH Splits each triangle in surface mesh into 4 congruent triangles
%% Examples
%   [v,f] = increasePatch(eye(3),1:3)
%   v = eye(3); f = 1:3; t = @(v,f,c) trimesh(f,v(:,1),v(:,2),v(:,3),c{:}); figure; t(v,f); [v,f] = increasePatch(v,f); hold on; t(v,f);
%   v = [1 3 0; 1 2 0; 2 2 0; 1 1 0; 2 1 0; 3 1 0]; f = [1 2 3; 2 4 5; 3 2 5; 3 5 6]; [v2,f2] = increasePatch(v,f); figure; plotSkeleton(v,f,'patchOptions', {'LineStyle', '--', 'FaceAlpha', 0,'LineWidth',2}); hold on; plotSkeleton(v2,f2);   
%   [v,f] = cuboidSurface(2,3,4); [v2,f2] = increasePatch(v,f); figure; plotSkeleton(v,f,'patchOptions', {'LineStyle', '--', 'FaceAlpha', 0,'LineWidth',2}); hold on; plotSkeleton(v2,f2);
%   [v,f] = torusMesh; [v2,f2] = increasePatch(v,f); figure; plotSkeleton(v,f,'patchOptions', {'LineStyle', '--', 'FaceAlpha', 0,'LineWidth',2}); hold on; plotSkeleton(v2,f2);
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

e = sort([ f(:,1),f(:,2) ; f(:,2),f(:,3) ; f(:,3),f(:,1) ], 2);
[E, ~, ej] = unique(e,'rows','sorted'); 
v2 = [v; (v(E(:,1),:) + v(E(:,2),:))/2];
fn = reshape(ej,[],3)+height(v);
f2 = [fn; [[fn(:,[1,3]); fn(:,[2,1]); fn(:,[3,2])], f(:)]];
% faces = [fn; fn(:,[1,3]), f(:,1); fn(:,[2,1]), f(:,2); fn(:,[3,2]), f(:,3)];

end

