function varargout = joinPatches(verts1, faces1, rois1, verts2, faces2, rois2)
%% JOINPATCHES Join 2 sets of verts and faces (and rois) combined into 1 model
%% Examples
%   [v1,f1] = sphereMesh; [v2,f2] = torusMesh; [v,f]=joinPatches(v1/2,f1,v2,f2); figure; patch('Vertices',v,'Faces',f); 
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


%   Inputs: any of:
%           - two structs: each must contain vertices and faces, and may
%           contain rois; OR
%           - verts1, faces1, verts2, faces2; OR
%           - verts1, faces1, rois1, verts2, faces2, rois2
%   Outputs: depends on the number of outputs requested
%           1. a struct containing vertices and faces, and potentially rois
%           2. a v*3 matrix of vertices, and an f*3 matrix of faces
%           3. (2) combined with a v*1 vector of roi allocations

% parse inputs, set base case as being 6 separate inputs
switch nargin
    case 2 % input is two structs (recursive call)
        struct1 = verts1; struct2 = faces1;
        if isfield(struct1, 'rois'); rois1 = strict1.rois; else; rois1 = []; end
        if isfield(struct2, 'rois'); rois2 = strict1.rois; else; rois2 = []; end
        [varargout{1:nargout}] = joinPatches(struct1.vertices, struct1.faces, rois1, struct2.vertices, struct2.faces, rois2);
        return;

    case 4 % input is verts1,faces1,verts2,faces2
        [varargout{1:nargout}] = joinPatches(verts1, faces1, [], rois1, verts2, []);
        return;

    case 6 % this is the bulk of the computation
        assert(size(verts1, 2) == 3);
        assert(size(faces1, 2) == 3);
        assert(max(faces1(:)) == size(verts1, 1));
        assert(size(verts2, 2) == 3);
        assert(size(faces2, 2) == 3);
        assert(max(faces2(:)) == size(verts2, 1));

        outputSurface.vertices = [verts1; verts2];
        outputSurface.faces = [faces1; faces2+size(verts1, 1)];

        if ~isempty(rois1) && ~isempty(rois2)
            assert(size(rois1, 1) == size(verts1, 1));
            assert(size(rois2, 1) == size(verts2, 1));
            outputSurface.rois = joinParcs(rois1, rois2);
        end

end

% set outputs: if only 1 output, return struct; if multiple, separate them
if nargout == 1
    varargout{1} = outputSurface;
else 
    varargout{1} = outputSurface.vertices;
    varargout{2} = outputSurface.faces;
    if isfield(outputSurface, 'rois'); varargout{3} = outputSurface.rois; end
end

end
