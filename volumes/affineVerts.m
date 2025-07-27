function out = affineVerts(verts, tform, isNiftiTform)
% Applies an affine transformation to a set of vertices.
%
% Usage:
%   out = affineVerts(verts, tform, isNiftiTform)
%
% Inputs:
%   verts         - A matrix of size nVerts x 3 or nVerts x 4, where each row
%                   represents a vertex in 3D space (or 4D if homogeneous 
%                   coordinates are used).
%   tform         - A 4x4 matrix representing the affine transformation to be 
%                   applied to the vertices.
%   isNiftiTform  - (Optional) A boolean flag indicating whether the transformation 
%                   is in NIfTI format. Default is false.
%
% Outputs:
%   out           - A matrix of transformed vertices of the same size as input 
%                   verts.
%
% Description:
% The function checks the dimensions of the input vertices and applies the 
% specified affine transformation. It handles both standard and NIfTI affine 
% transformations, ensuring that the output vertices are correctly transformed 
% based on the input parameters.
%
% Warnings:
% The function will issue warnings if the provided transformation matrix and 
% the NIfTI flag are inconsistent.
%
% Example:
%   transformedVerts = affin(vertices, transformationMatrix, true);
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 

assert(ismember(size(verts, 2), [3, 4]), 'vertices should be of shape nVerts*3 or nVerts*4');
%if w==3; verts(:,4) = 1; end % this is slow, dont do this

if nargin < 3 || isempty(isNiftiTform); isNiftiTform = false; end

s = 'Unexpected tform and nifti flag detected. Are the parameters input correctly?';
if      isNiftiTform && any(tform(13:15 ))
    warning(s);
elseif ~isNiftiTform && any(tform(4:4:12))
    warning(s);
end

if isNiftiTform
    
    %out = verts*tform;      % equivalent to (tform'*verts')'

    % it is faster to avoid the 1's
    if size(verts, 2) == 4
        out = verts(:, 1:3) * tform(1:3, 1:3) + tform(4, 1:3);
    else
        out = verts * tform(1:3, 1:3) + tform(4, 1:3);
    end
else
    %out = verts*tform'; % equivalent to (tform *verts')'
    % it is faster to avoid the 1's
    if size(verts, 2) == 4
        out = verts(:, 1:3) * tform(1:3, 1:3)' + tform(1:3, 4)';
    else
        out = verts * tform(1:3, 1:3)' + tform(1:3, 4)';
    end
end

% if we have to
if size(verts, 2) == 4
    out(:, 4) = 1;
end