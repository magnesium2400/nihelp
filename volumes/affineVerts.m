function out = affineVerts(verts, tform, isNiftiTform)
%% AFFINEVERTS Apply affine (e.g. NIfTI tform) transformation to vertices
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


w = size(verts, 2); 
assert(w==3 || w==4, 'vertices should be of shape nVerts*3 or nVerts*4');
if w==3; verts(:,4) = 1; end

if nargin < 3 || isempty(isNiftiTform); isNiftiTform = false; end

s = 'Unexpected tform and nifti flag detected. Are the parameters input correctly?';
if      isNiftiTform && any(tform(13:15 )); warning(s);
elseif ~isNiftiTform && any(tform(4:4:12)); warning(s);     end

if isNiftiTform;    out = verts*tform;      % equivalent to (tform'*verts')'
else;               out = verts*tform'; end % equivalent to (tform *verts')'

out = out(:,1:w); 

end
