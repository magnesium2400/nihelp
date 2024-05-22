function out = faceNormal(verts, faces)
%% FACENORMAL Vector normal to at each face in surface mesh
%% Examples
%   out = faceNormal([1 0 0; 0 1 0; 0 0 1], [1 2 3])
%   out = faceNormal([1 0 0; 0 1 0; 0 0 1; 0 0 0], [1 2 3; 1 4 2; 1 3 4; 2 4 3])
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

% out = (verts\ones(height(verts),1))'; 

temp = permute(reshape( verts(faces,:),[],3,3 ) , [1 3 2]);
out = cross(temp(:,:,2) - temp(:,:,1), temp(:,:,3) - temp(:,:,1),2);


end

