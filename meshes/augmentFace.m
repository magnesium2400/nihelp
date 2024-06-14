function [verts, faces] = augmentFace(verts, faces, faceIds)
%% AUGMENTFACE Replaces face in surface mesh with tetrahedron
%% Usage Notes
% Old faces are removed from their location in the `faces` matrix, and new faces
% are all added to the end
%
%
%% Examples
%   v=[eye(3); 0 0 0]; f=[1 2 3; 1 4 2; 1 3 4; 2 4 3]; [v,f]=augmentFace(v,f);
%   [v,f]=squareMesh3(3); [v,f]=augmentFace(v,f); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal 
%   [v,f]=squareMesh3(5); [v,f]=augmentFace(v,f,1:2:height(f)); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal 
%   v=eye(3); f=1:3; for ii=1:3;[v,f]=augmentFace(v,f); end; figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal 
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

if nargin < 3 || isempty(faceIds); faceIds = 1:height(faces); end

f = faces(faceIds,:); 
n = faceNormal(verts, f); % normal to each face
vc = permute(reshape( verts(f,:),[],3,3 ) , [1 3 2]); 
vm = squeeze(mean(vc, 3)); % centre of each face

vn = vm + n./sqrt(vecnorm(n,2,2))*(2/3^0.75); % new vertices
fn = kron(f, [1;1;1]).*kron(ones(numel(faceIds),1), ~eye(3)) + kron(height(verts)+(1:numel(faceIds))',eye(3)); 
verts = [verts; vn]; 
faces = [faces(setdiff(1:height(faces), faceIds),:); fn];

%%


% face = faces(faceId,:); 
% vc = verts(face,:); 
% vm = mean(vc); 
% fn = faceNormal(vc); 
% 
% verts(end+1, :) = vm + fn/vecnorm(fn,2,2)*sqrt(2)*mean(vecnorm(vm-vc,2,2),1);
% 
% faces = [faces; repmat(face,3,1)-diag(face)+eye(3)*height(verts)];

end


